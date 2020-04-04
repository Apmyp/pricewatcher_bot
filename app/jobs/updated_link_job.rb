class UpdatedLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    message = Telegram::MakeMessageForUpdatedLink.call(link)
    NotifyTelegramUser.call(link.telegram_user, message)
  end
end
