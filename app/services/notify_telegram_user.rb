class NotifyTelegramUser
  def self.call(user, message)
    new.call(user, message)
  end

  def call(user, message)
    Telegram.bot.send_message(chat_id: user.external_id, text: message)
  end
end