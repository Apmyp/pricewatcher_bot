module Telegram
  class MakeIkForCreateLink
    def self.call(user)
      new.call(user)
    end

    def call(_)
      [
          {}.tap do |h|
            h['text'] = "🔗 Добавить ещё ссылку"
            h['callback_data'] = "create_link"
          end
      ]
    end
  end
end