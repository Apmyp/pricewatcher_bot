# frozen_string_literal: true

module Links
  class PerformLink
    def self.call(*args)
      new.call(*args)
    end

    def call(link)
      parser_const = Parsers::ParserChooser.call(link)
      parser_item = parser_const.call(link.link)

      if link.link_items.empty?
        return [AttachLinkItem.call(link, parser_item), nil]
      end

      diff = item_data_differs?(link, parser_item)
      return [AttachLinkItem.call(link, parser_item), diff] unless diff.nil?

      [nil, nil]
    end

    private

    def item_data_differs?(link, parser_item)
      converted_li = Parsers::ConvertToParserItem.call(link.active_link_item)
      Parsers::ParserItemDiffers.call(converted_li, parser_item)
    end
  end
end
