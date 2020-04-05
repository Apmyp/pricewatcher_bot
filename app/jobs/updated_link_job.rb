# frozen_string_literal: true

class UpdatedLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    message = Telegram::MakeMessageForUpdatedLink.call(link)
    NotifyTelegramUser.call(
      user: link.telegram_user,
      photo: link&.active_link_item&.image,
      raw_link: link.link,
      message: message
    )
  end
end
