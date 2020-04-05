# frozen_string_literal: true

module Telegram
  class MakeIkLink
    def self.call(*args)
      new.call(*args)
    end

    def call(text:, action:)
      {}.tap do |h|
        h['text'] = text
        h['url'] = action
      end
    end
  end
end
