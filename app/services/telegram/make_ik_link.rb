module Telegram
  class MakeIkLink
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