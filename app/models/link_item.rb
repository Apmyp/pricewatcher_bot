class LinkItem < ApplicationRecord
  enum status: %i[active pending]

  belongs_to :link

  scope :ordered, -> { order('id DESC') }

  def price_with_currency
    @price_with_currency ||= "#{price.to_i}#{currency}"
  end
end
