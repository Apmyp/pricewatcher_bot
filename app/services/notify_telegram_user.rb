# frozen_string_literal: true

class NotifyTelegramUser
  def self.call(*args)
    new(*args).call
  end

  def initialize(user:, response:)
    @user = user
    @response = response
  end

  def call
    if response.photo?
      Telegram.bot.send_photo(options)
    else
      Telegram.bot.send_message(options)
    end
  end

  protected

  attr_reader :user, :response

  def options
    {
      chat_id: user.external_id
    }.merge(response.call)
  end
end
