class TelegramController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start!(*)
    current_user = FindOrCreateTelegramUser.call(from)
    respond_with :message, text: "*Привет, #{current_user.first_name}!*\nКак тебе наш бот?", parse_mode: :Markdown
  end
end