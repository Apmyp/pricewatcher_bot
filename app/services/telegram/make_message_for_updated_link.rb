# frozen_string_literal: true

module Telegram
  class MakeMessageForUpdatedLink
    def self.call(*args)
      new.call(*args)
    end

    def call(link)
      active_li = link.active_link_item
      prev_li = link.prev_link_item

      if prev_li.present?
        updated_link_item(active_li, prev_li)
      else
        new_link_item(active_li)
      end
    end

    private

    def new_link_item(link_item)
      I18n.t('telegram.new_link_item',
             new_link_item_options(link_item))
    end

    def updated_link_item(active_li, prev_li)
      I18n.t('telegram.updated_link_item',
             updated_link_item_options(active_li, prev_li))
    end

    def new_link_item_options(link_item)
      {}.tap do |h|
        if link_item.present?
          h[:name] = link_item.name
          h[:price] = link_item.price_with_currency
          h[:availability] =
            I18n.t("telegram.availability.#{link_item.availability}")
        end
      end
    end

    def updated_link_item_options(active_li, prev_li)
      {}.tap do |h|
        h.merge!(new_link_item_options(active_li))

        if prev_li.present?
          h[:prev_price] = prev_price(active_li, prev_li)
          h[:prev_availability] = prev_availability(active_li, prev_li)
        end
      end
    end

    def prev_price(active_li, prev_li)
      return unless active_li.price_with_currency != prev_li.price_with_currency

      "(было: #{prev_li.price_with_currency})"
    end

    def prev_availability(active_li, prev_li)
      return unless active_li.availability != prev_li.availability

      "(было: #{I18n.t("telegram.availability.#{prev_li.availability}")})"
    end
  end
end
