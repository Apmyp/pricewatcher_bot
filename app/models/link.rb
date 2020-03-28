class Link < ApplicationRecord
  enum status: %i[active disabled]

  validates_presence_of :link, :host, :scheme, :status

  has_many :link_items, dependent: :destroy
end
