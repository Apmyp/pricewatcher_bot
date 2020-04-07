# frozen_string_literal: true

class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Skylight::Helpers

  before_action :set_current_user
  before_action :set_raven_context
  around_action :wrap_in_raven
  around_action :wrap_in_skylight

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

  def stop!(*)
    current_user.update(status: :disabled)
    respond_with :message, text: t('.stop', first_name: current_user.first_name)
  end

  def mylinks!(*)
    response = Responses::LinksResponse.new(current_user)
    respond_with response.type, response.call
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
      response = Responses::LinksResponse.new(current_user)
      respond_with response.type, response.call
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

  def wrap_in_skylight
    Skylight.instrument title: "Running telegram command" do
      yield
    end
  end

  def show_link_callback(data)
    link_id = data.scan(/^link\:(\d+)/).first.first.to_i

    response = Responses::LinkResponse.new(Link.find(link_id), current_user)
    respond_with response.type, response.call
  end

  def destroy_link_callback(data)
    destroy_link(data)
  rescue ActiveRecord::RecordNotFound
    answer_callback_query(t('.link_destroyed'))
  else
    answer_callback_query(t('.link_destroyed'))

    response = Responses::LinksResponse.new(current_user)
    respond_with response.type, response.call
  end

  def destroy_link(data)
    link_id = data.scan(/^destroy_link\:(\d+)/).first.first.to_i
    Link.find(link_id).destroy
  end

  def process_new_link(raw_link)
    link = Links::CreateLink.call(current_user, raw_link)
    ParseLinkJob.set(wait: 5.seconds).perform_later(link)
  rescue ActiveRecord::RecordInvalid => e
    save_context :newlink!

    respond_with :message, text: t('.link_not_added')
    log_error(e, raw_link)
  else
    response = Responses::LinkAddedResponse.new(link, current_user)
    respond_with response.type, response.call
  end

  def log_error(exception, raw_link)
    logger.info(
      'I cant create the link. Can you investigate why? '\
    "Link: #{raw_link}. Errors: #{exception.record.errors.to_json}"
    )
  end

  def parsers_hosts
    @parsers_hosts ||= Parsers::ParserChooser.parsers_hosts
  end
end
