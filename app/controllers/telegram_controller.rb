# frozen_string_literal: true

class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user

  def start!(*)
    current_user.update(status: :active)
    respond_with :message,
                 text: t('.start',
                         first_name: current_user.first_name)
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
      process_new_link(raw_link)
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
    @set_current_user ||= @current_user ||= FindOrCreateTelegramUser.call(from)
  end

  def process_new_link(raw_link)
    link = Links::CreateLink.call(current_user, raw_link)
  rescue Links::PathNotFoundException, ActiveRecord::RecordInvalid
    save_context :newlink!
    respond_with :message, text: t('.link_not_added')
    logger.info(
      "I cant create the link. Can you investigate why? Link: #{raw_link}"
    )
  else
    respond_with :message, link_added(link)
  end

  def links
    {
      text: t('.links', count: current_user.active_links.count), reply_markup: {
        inline_keyboard: links_ik(current_user.active_links)
      }
    }
  end

  def links_ik(links)
    [].concat(Telegram::MakeIkForLinks.call(links))
      .concat([[button(text: t('.add_link'), action: 'create_link')]])
  end

  def respond_with_link(link)
    response = LinkResponse.new(link)
    respond_with response.respond_type, response.params
  end

  def link_added(link)
    { text: t('.link_added', link_name: link.display_name), reply_markup: {
      inline_keyboard: [
        [button(text: t('.delete_link'), action: "destroy_link:#{link.id}")],
        [button(text: t('.add_link'), action: 'create_link')],
        [button(text: t('.link_added_back'), action: 'links')]
      ]
    } }
  end

  def button(text:, action:)
    Telegram::MakeIkLink.call(text: text, action: action)
  end
end
