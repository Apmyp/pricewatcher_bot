# frozen_string_literal: true

namespace :stats do
  desc 'Send stats to admins'
  task send: :environment do
    TelegramUser.admin.find_each do |user|
      SendStatsToAdminJob.perform_later(user)
    end
  end
end
