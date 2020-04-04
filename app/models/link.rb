class Link < ApplicationRecord
  enum status: %i[active disabled]

  validates_presence_of :telegram_user, :link, :host, :scheme, :status

  has_many :link_items, dependent: :destroy
  has_one :active_link_item, -> { active.ordered }, class_name: 'LinkItem'
  has_one :prev_link_item, -> { pending.order('id DESC') }, class_name: 'LinkItem'
  belongs_to :telegram_user

  scope :ordered, -> { order('id DESC') }

  def display_name
    @display_name ||= begin
                        if active_link_item.present?
                          item = active_link_item
                          "#{item.name} (#{item.price.to_i}#{item.currency})"
                        else
                          "#{host} (\##{hash_id})"
                        end
                      end
  end
end
