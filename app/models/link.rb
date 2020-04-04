# frozen_string_literal: true

class Link < ApplicationRecord
  enum status: { active: 0, disabled: 1 }

  validates :telegram_user, :link, :host, :scheme, :status, presence: true

  has_many :link_items, dependent: :destroy
  has_one :active_link_item,
          -> { active.ordered },
          class_name: 'LinkItem',
          inverse_of: :link
  has_one :prev_link_item,
          -> { pending.order('id DESC') },
          class_name: 'LinkItem',
          inverse_of: :link
  belongs_to :telegram_user

  scope :ordered, -> { order('id DESC') }

  def display_name
    @display_name ||= begin
                        if active_link_item.present?
                          item = active_link_item
                          "#{item.name} (#{item.price_with_currency})"
                        else
                          "#{host} (\##{hash_id})"
                        end
                      end
  end
end
