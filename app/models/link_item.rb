class LinkItem < ApplicationRecord
  enum status: %i[active pending]

  belongs_to :link
end
