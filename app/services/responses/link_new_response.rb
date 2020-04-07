# frozen_string_literal: true

module Responses
  class LinkNewResponse < ALinkResponse
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

    def photo
      active_li.image
    end

    def text
      I18n.t('telegram.new_link_item',
             options(active_li))
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

    def options(link_item)
      {}.tap do |h|
        if link_item.present?
          h[:name] = link_item.name
          h[:price] = link_item.price_with_currency
          h[:availability] =
            I18n.t("telegram.availability.#{link_item.availability}")
        end
      end
    end
  end
end
