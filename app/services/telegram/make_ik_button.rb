# frozen_string_literal: true

module Telegram
  class MakeIkButton
    def self.call(*args)
      new.call(*args)
    end

    def call(text:, action:)
      {}.tap do |h|
        h['text'] = text
        h['callback_data'] = action
      end
    end
  end
end
