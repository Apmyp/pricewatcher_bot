# frozen_string_literal: true

class Link < ApplicationRecord
  NANOID_ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyz'

  enum status: { active: 0, disabled: 1 }

  validates :telegram_user, :link, :host, :scheme, :status, presence: true
  validates :link, uniqueness: { scope: :telegram_user_id }
  validate :link_can_be_parsed

  has_many :requests, dependent: :destroy
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
  counter_culture :telegram_user,
                  column_name: proc { |m|
                    m.active? ? 'active_links_count' : nil
                  }

  scope :ordered, -> { order('id DESC') }

  before_create :set_hash_id

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

  def link_can_be_parsed
    Parsers::ParserChooser.call(self)
  rescue Parsers::ParserChooser::ParserNotFoundException
    errors.add(:link, "can't be parsed")
  end

  def set_hash_id
    self.hash_id = Nanoid.generate(alphabet: NANOID_ALPHABET)
  end
end
