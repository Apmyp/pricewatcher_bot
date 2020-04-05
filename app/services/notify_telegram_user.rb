# frozen_string_literal: true

class NotifyTelegramUser
  def self.call(*args)
    new.call(*args)
  end

  def call(user:, photo:, raw_link:, message:)
    Telegram.bot.send_photo(
      chat_id: user.external_id,
      photo: photo,
      caption: message,
      parse_mode: :Markdown,
      reply_markup: {
        inline_keyboard: inline_keyboard(raw_link)
      }
    )
  end

  private

  def inline_keyboard(raw_link)
    [
      [Telegram::MakeIkLink.call(
        text: I18n.t('telegram.show_link'),
        url: raw_link
      )],
      [Telegram::MakeIkButton.call(
        text: I18n.t('telegram.link_added_back'),
        action: 'links'
      )]
    ]
  end
end
