class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :set_current_user

  def start!(*)
    msg = "*Привет, #{current_user.first_name}!*\nКак тебе наш бот?"
    respond_with :message, text: msg, parse_mode: :Markdown
  end

  def stop!(*)
    msg = "Больше мы тебя не побеспокоим"
    respond_with :message, text: msg, parse_mode: :Markdown
  end

  def mylinks!(*)
    msg = "У тебя пока нет ссылок!"
    respond_with :message, text: msg, parse_mode: :Markdown
  end

  def newlink!(raw_link = nil, *)
    if raw_link
      link = Links::CreateLink.call(current_user, raw_link)
      msg = "Добавлена ссылка #{link.host} (\##{link.hash_id})"
      respond_with :message, text: msg, parse_mode: :Markdown
    else
      save_context :newlink!
      msg = "Скинь ссылку на товар. Мы поддерживаем тех-то и вон тех-то"
      respond_with :message, text: msg, parse_mode: :Markdown
    end
  end

  private

  attr_reader :current_user

  def set_current_user
    @current_user ||= FindOrCreateTelegramUser.call(from)
  end
end