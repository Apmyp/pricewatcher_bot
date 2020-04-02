class TelegramUser < ApplicationRecord
  enum status: %i[active disabled]

  has_many :links, dependent: :destroy
end
