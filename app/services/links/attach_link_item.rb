# frozen_string_literal: true

module Links
  class AttachLinkItem
    def self.call(*args)
      new.call(*args)
    end

    def call(link, parser_item)
      ActiveRecord::Base.transaction do
        reset_active_status(link)
        attach_link_item(link, parser_item)
      end
    end

    private

    def reset_active_status(link)
      link.link_items.find_each do |link_item|
        link_item.update(status: :pending)
      end
    end

    def attach_link_item(link, parser_item)
      link.link_items.create(
        name: parser_item.name,
        image: parser_item.image,
        price: parser_item.price,
        currency: parser_item.currency,
        availability: parser_item.availability,
        status: :active
      )
    end
  end
end
