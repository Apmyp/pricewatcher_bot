# frozen_string_literal: true

module Telegram
  class MakeIkLink
    def self.call(*args)
      new.call(*args)
    end

    def call(text:, url:)
      {}.tap do |h|
        h['text'] = text
        h['url'] = url
      end
    end
  end
end
