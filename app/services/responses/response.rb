module Responses
  class Response
    def self.call(*args)
      new(*args).call
    end

    def initialize(user)
      @user = user
    end

    def call
      to_h
    end

    def to_h
      {
          text: text,
          reply_markup: reply_markup
      }
    end

    def type
      raise ::StandardError.new
    end

    protected

    attr_reader :user

    def reply_markup
      {
          inline_keyboard: inline_keyboard
      }
    end

    def button(text:, action:)
      Telegram::MakeIkButton.call(text: text, action: action)
    end

    def link(text:, url:)
      Telegram::MakeIkLink.call(text: text, url: url)
    end
  end
end