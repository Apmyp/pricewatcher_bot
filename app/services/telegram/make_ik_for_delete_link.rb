module Telegram
  class MakeIkForDeleteLink
    def self.call(link)
      new.call(link)
    end

    def call(link)
      [
          {}.tap do |h|
            h['text'] = "🗑 Удалить ссылку #{link.display_name}"
            h['callback_data'] = "destroy_link:#{link.id}"
          end
      ]
    end
  end
end