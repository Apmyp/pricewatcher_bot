class LinkItem < ApplicationRecord
  enum status: %i[active pending]

  belongs_to :link

  scope :ordered, -> { order('id DESC') }
end
