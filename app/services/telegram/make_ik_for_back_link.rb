module Telegram
  class MakeIkForBackLink
    def self.call(text: 'Вернуться', action:)
      new.call(text, action)
    end

    def call(text = 'Вернуться', action)
      {}.tap do |h|
        h['text'] = "← #{text}"
        h['callback_data'] = action
      end
    end
  end
end