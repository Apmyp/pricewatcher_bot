# frozen_string_literal: true

class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user
  before_action :set_raven_context
  around_action :wrap_in_raven

  def start!(*)
    current_user.update(status: :active)
    respond_with :message,
                 text: t('.start',
                         first_name: current_user.first_name,
                         parsers_hosts: parsers_hosts)
  end

  def help!(*)
    respond_with :message, text: t('.help',
                                   first_name: current_user.first_name,
                                   parsers_hosts: parsers_hosts)
  end

  def action_missing
    respond_with :message, text: t('.help',
                                   first_name: current_user.first_name,
                                   parsers_hosts: parsers_hosts)
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
      respond_with :message, text: t('.new_link', parsers_hosts: parsers_hosts)
    end
  end

  def callback_query(data)
    if data == 'links'
      respond_with :message, links
    elsif data[/^link:\d+/]
      show_link_callback(data)
    elsif data[/^destroy_link:\d+/]
      destroy_link_callback(data)
    elsif data == 'create_link'
      newlink!
    end
  end

  private

  attr_reader :current_user

  def set_current_user
    @set_current_user ||= @current_user ||= FindOrCreateTelegramUser.call(from)
  end

  def set_raven_context
    Raven.user_context(id: current_user.id)
    Raven.extra_context(telegram_chat_id: current_user.external_id)
  end

  def wrap_in_raven
    yield
  rescue StandardError => e
    Raven.capture_exception(e)
    raise e
  end

  def show_link_callback(data)
    link_id = data.scan(/^link\:(\d+)/).first.first.to_i
    respond_with_link Link.find(link_id)
  end

  def destroy_link_callback(data)
    link_id = data.scan(/^destroy_link\:(\d+)/).first.first.to_i
    Link.find(link_id).destroy
  rescue ActiveRecord::RecordNotFound
    answer_callback_query(t('.link_destroyed'))
  else
    answer_callback_query(t('.link_destroyed'))
    respond_with :message, links
  end

  def process_new_link(raw_link)
    link = Links::CreateLink.call(current_user, raw_link)
    ParseLinkJob.set(wait: 5.seconds).perform_later(link)
  rescue ActiveRecord::RecordInvalid
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
    {text: t('.link_added', link_name: link.display_name), reply_markup: {
        inline_keyboard: [
            [button(text: t('.delete_link'), action: "destroy_link:#{link.id}")],
            [button(text: t('.add_link'), action: 'create_link')],
            [button(text: t('.link_added_back'), action: 'links')]
        ]
    }}
  end

  def button(text:, action:)
    Telegram::MakeIkLink.call(text: text, action: action)
  end

  def parsers_hosts
    @parsers_hosts ||= Parsers::ParserChooser.parsers_hosts
  end
end
