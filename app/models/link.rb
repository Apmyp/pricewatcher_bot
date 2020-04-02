class Link < ApplicationRecord
  enum status: %i[active disabled]

  validates_presence_of :telegram_user, :link, :host, :scheme, :status

  has_many :link_items, dependent: :destroy
  has_one :active_link_item, -> { active.ordered }, class_name: 'LinkItem'
  belongs_to :telegram_user
end
