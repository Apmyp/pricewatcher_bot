# frozen_string_literal: true

class TelegramUser < ApplicationRecord
  enum status: { active: 0, disabled: 1 }
  enum role: { user: 0, admin: 1 }

  has_many :links,
           dependent: :destroy,
           inverse_of: :telegram_user

  has_many :active_links,
           -> { active.ordered },
           class_name: 'Link',
           inverse_of: :telegram_user
end
