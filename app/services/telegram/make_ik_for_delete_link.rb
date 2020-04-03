module Telegram
  class MakeIkForDeleteLink
    def self.call(link)
      new.call(link)
    end

    def call(link)
      {}.tap do |h|
        h['text'] = "🗑 Удалить ссылку"
        h['callback_data'] = "destroy_link:#{link.id}"
      end
    end
  end
end