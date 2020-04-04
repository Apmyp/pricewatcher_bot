class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user

  def start!(*)
    current_user.update(status: :active)
    respond_with :message, text: t('.start', first_name: current_user.first_name)
  end

  def help!(*)
    respond_with :message, text: t('.help', first_name: current_user.first_name)
  end

  def stop!(*)
    current_user.update(status: :disabled)
    respond_with :message, text: t('.stop', first_name: current_user.first_name)
  end

  def mylinks!(*)
    respond_with :message, links
  end

  def newlink!(raw_link = nil, *)
    if raw_link
      begin
        link = Links::CreateLink.call(current_user, raw_link)
      rescue Links::PathNotFoundException, ActiveRecord::RecordInvalid
        save_context :newlink!
        respond_with :message, text: t('.link_not_added')
        logger.info "I cant create the link. Can you investigate why? Link: #{raw_link}"
      else
        respond_with :message, link_added(link)
      end
    else
      save_context :newlink!
      respond_with :message, text: t('.new_link')
    end
  end

  def callback_query(data)
    if data == 'links'
      respond_with :message, links
    elsif data[/^link:\d+/]
      link_id = data.scan(/^link\:(\d+)/).first.first.to_i
      respond_with_link Link.find(link_id)
    elsif data[/^destroy_link:\d+/]
      begin
        link_id = data.scan(/^destroy_link\:(\d+)/).first.first.to_i
        Link.find(link_id).destroy
      rescue ActiveRecord::RecordNotFound
        answer_callback_query(t('.link_destroyed'))
      else
        answer_callback_query(t('.link_destroyed'))
        respond_with :message, links
      end
    elsif data == 'create_link'
      newlink!
    end
  end

  private

  attr_reader :current_user

  def set_current_user
    @current_user ||= FindOrCreateTelegramUser.call(from)
  end

  def links
    {
        text: t('.links', count: current_user.active_links.count), reply_markup: {
        inline_keyboard: Telegram::MakeIkForLinks.call(current_user.active_links)
                             .concat([[Telegram::MakeIkLink.call(text: t('.add_link'), action: 'create_link')]])}
    }
  end

  def respond_with_link(link)
    respond_with link_respond_type(link), link_params(link)
  end

  def link_params(link)
    link.active_link_item.present? ? photo_link(link) : message_link(link)
  end

  def link_respond_type(link)
    link.active_link_item.present? ? :photo : :message
  end

  def link_locale_name(link)
    if link.active_link_item.blank?
      '.link_without_item'
    elsif link.active_link_item.present? && link.prev_link_item.blank?
      '.link'
    elsif link.active_link_item.present? && link.prev_link_item.present?
      '.link_with_prev'
    else
      '.link_without_item'
    end
  end

  def link_options(link)
    {}.tap do |h|
      h[:display_name] = link.display_name

      link_item = link.active_link_item

      if link_item.present?
        h[:name] = link_item.name
        h[:price] = link_item.price_with_currency
        h[:availability] = t(".availability.#{link_item.availability.to_s}")
      end

      prev_link_item = link.prev_link_item

      if prev_link_item.present?
        h[:prev_price] = prev_link_item.price_with_currency
      end

      h
    end
  end

  def photo_link(link)
    {
        photo: link.active_link_item.image,
        caption: t(link_locale_name(link), link_options(link)),
        parse_mode: :Markdown,
        reply_markup: {
            inline_keyboard: [
                [
                    Telegram::MakeIkLink.call(text: t('.delete_link'), action: "destroy_link:#{link.id}"),
                    Telegram::MakeIkLink.call(text: t('.back'), action: 'links'),
                ]
            ]}
    }
  end

  def message_link(link)
    {
        text: t(link_locale_name(link), link_options(link)),
        parse_mode: :Markdown,
        reply_markup: {
            inline_keyboard: [
                [
                    Telegram::MakeIkLink.call(text: t('.delete_link'), action: "destroy_link:#{link.id}"),
                    Telegram::MakeIkLink.call(text: t('.back'), action: 'links'),
                ]
            ]}
    }
  end

  def link_added(link)
    {text: t('.link_added', link_name: link.display_name), reply_markup: {
        inline_keyboard: [
            [Telegram::MakeIkLink.call(text: t('.delete_link'), action: "destroy_link:#{link.id}")],
            [Telegram::MakeIkLink.call(text: t('.add_link'), action: 'create_link')],
            [Telegram::MakeIkLink.call(text: t('.link_added_back'), action: 'links')],
        ]}}
  end
end