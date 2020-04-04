# frozen_string_literal: true

class LinkItem < ApplicationRecord
  enum status: { active: 0, pending: 1 }

  belongs_to :link

  scope :ordered, -> { order('id DESC') }

  def price_with_currency
    @price_with_currency ||= "#{price.to_i}#{currency}"
  end
end
