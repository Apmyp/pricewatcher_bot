module Telegram
  class MakeIkForCreateLink
    def self.call
      new.call
    end

    def call
      [
          {}.tap do |h|
            h['text'] = "🔗 Добавить ещё ссылку"
            h['callback_data'] = "create_link"
          end
      ]
    end
  end
end