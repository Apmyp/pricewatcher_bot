# frozen_string_literal: true

class UpdatedLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    message = Telegram::MakeMessageForUpdatedLink.call(link)
    NotifyTelegramUser.call(
      link.telegram_user,
      link&.active_link_item&.image,
      message
    )
  end
end
