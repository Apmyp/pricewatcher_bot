# frozen_string_literal: true

class SendStatsToAdminJob < ApplicationJob
  queue_as :default

  def perform(user)
    return unless user.admin?

    NotifyTelegramUser.call(
      user: user,
      response: Responses::StatsResponse.new(user)
    )
  end
end
