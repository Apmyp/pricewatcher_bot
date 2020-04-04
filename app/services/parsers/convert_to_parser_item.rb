# frozen_string_literal: true

module Parsers
  class ConvertToParserItem
    def self.call(*args)
      new.call(*args)
    end

    def call(link_item)
      ParserItem.new(
        name: link_item.name,
        image: link_item.image,
        price: link_item.price.to_i.to_s,
        currency: link_item.currency,
        availability: link_item.availability
      )
    end
  end
end
