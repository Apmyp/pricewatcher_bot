module Telegram
  class MakeMessageForUpdatedLink
    def self.call(*args)
      new.call(*args)
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
      I18n.t('telegram.new_link_item', new_link_item_options(link_item))
    end

    def updated_link_item(active_link_item, prev_link_item)
      I18n.t('telegram.updated_link_item', updated_link_item_options(active_link_item, prev_link_item))
    end

    def new_link_item_options(link_item)
      {}.tap do |h|
        if link_item.present?
          h[:name] = link_item.name
          h[:price] = link_item.price_with_currency
          h[:availability] = I18n.t("telegram.availability.#{link_item.availability.to_s}")
        end

        h
      end
    end

    def updated_link_item_options(active_link_item, prev_link_item)
      {}.tap do |h|
        h.merge!(new_link_item_options(active_link_item))

        if prev_link_item.present?
          h[:prev_price] = if active_link_item.price_with_currency != prev_link_item.price_with_currency
                             "(было: #{prev_link_item.price_with_currency})"
                           end

          h[:prev_availability] = if active_link_item.availability != prev_link_item.availability
                                    "(было: #{I18n.t("telegram.availability.#{prev_link_item.availability.to_s}")})"
                                  end
        end

        h
      end
    end
  end
end