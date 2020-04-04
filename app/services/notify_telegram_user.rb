class NotifyTelegramUser
  def self.call(user, message)
    new.call(user, message)
  end

  def call(user, message) end
end