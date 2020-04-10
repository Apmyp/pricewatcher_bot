# frozen_string_literal: true

class UpdatedLinkJob < ApplicationJob
  queue_as :default

  def perform(link)
    Raven.extra_context(link_id: link.id, link: link.link)
    response_const = if link.prev_link_item.present?
                       Responses::LinkUpdatedResponse
                     else
                       Responses::LinkNewResponse
                     end

    NotifyTelegramUser.call(
      user: link.telegram_user,
      response: response_const.new(link, link.telegram_user)
    )
  end
end
