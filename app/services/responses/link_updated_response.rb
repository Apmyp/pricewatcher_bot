# frozen_string_literal: true

module Responses
  class LinkUpdatedResponse < ALinkResponse
    def type
      :photo
    end

    def to_h
      {
        photo: photo,
        caption: text,
        reply_markup: reply_markup,
        parse_mode: :Markdown
      }
    end

    protected

    def active_li
      @active_li ||= current_link.active_link_item
    end

    def prev_li
      @prev_li ||= current_link.prev_link_item
    end

    def photo
      active_li.image
    end

    def text
      I18n.t('telegram.updated_link_item',
             options(active_li, prev_li))
    end

    def inline_keyboard
      [
        [link(
          text: I18n.t('telegram.show_link'),
          url: current_link.link
        )],
        [button(
          text: I18n.t('telegram.link_added_back'),
          action: 'links'
        )]
      ]
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

    def options(active_li, prev_li)
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
