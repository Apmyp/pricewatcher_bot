class TelegramUser < ApplicationRecord
  enum status: %i[active disabled]

  has_many :links, dependent: :destroy
  has_many :active_links, -> { active.ordered }, class_name: 'Link'
end
