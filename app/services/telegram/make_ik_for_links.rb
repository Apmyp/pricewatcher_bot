module Telegram
  class MakeIkForLinks
    def self.call(links)
      new.call(links)
    end

    def call(links)
      links.map do |link|
        [
            {}.tap do |h|
              h['text'] = link.display_name
              h['callback_data'] = "link:#{link.id}"
            end
        ]
      end
    end
  end
end