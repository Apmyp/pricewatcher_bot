# frozen_string_literal: true

class LinkResponse
  def initialize(link)
    @link = link
  end

  def params
    @params ||= active_li.present? ? photo : message
  end

  def respond_type
    @respond_type ||= active_li.present? ? :photo : :message
  end

  def locale_name
    @locale_name ||= if active_li.blank?
                       'telegram.link_without_item'
                     elsif active_li.present? && prev_li.blank?
                       'telegram.link'
                     elsif active_li.present? && prev_li.present?
                       'telegram.link_with_prev'
                     else
                       'telegram.link_without_item'
                     end
  end

  def options
    @options ||= {}.tap do |h|
      h[:display_name] = link.display_name

      h.merge!(active_li_options)

      h[:prev_price] = prev_li.price_with_currency if prev_li.present?
    end
  end

  def active_li_options
    return {} if active_li.blank?

    {}.tap do |h|
      h[:name] = active_li.name
      h[:price] = active_li.price_with_currency
      h[:availability] = I18n.t("telegram.availability.#{active_li.availability}")
    end
  end

  def photo
    {
      photo: active_li.image,
      caption: I18n.t(locale_name, options),
      parse_mode: :Markdown,
      reply_markup: {
        inline_keyboard: message_ik
      }
    }
  end

  def message
    {
      text: I18n.t(locale_name, options),
      parse_mode: :Markdown,
      reply_markup: {
        inline_keyboard: message_ik
      }
    }
  end

  def message_ik
    [
      [
        button(
          text: I18n.t('telegram.delete_link'),
          action: "destroy_link:#{link.id}"
        ),
        button(text: I18n.t('telegram.back'), action: 'links')
      ]
    ]
  end

  private

  attr_reader :link

  def active_li
    @active_li ||= link.active_link_item
  end

  def prev_li
    @prev_li ||= link.prev_link_item
  end

  def button(text:, action:)
    Telegram::MakeIkLink.call(text: text, action: action)
  end
end
