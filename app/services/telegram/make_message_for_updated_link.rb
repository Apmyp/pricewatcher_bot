module Telegram
  class MakeMessageForUpdatedLink
    def self.call(link)
      new.call(link)
    end

    def call(link)
      active_link_item = link.active_link_item
      prev_link_item = link.prev_link_item

      if prev_link_item.present?
        updated_link_item(active_link_item, prev_link_item)
      else
        new_link_item(active_link_item)
      end
    end

    private

    def new_link_item(link_item)
      "Новые данные подъехали"
    end

    def updated_link_item(active_link_item, prev_link_item)
      "Обновились данные"
    end
  end
end