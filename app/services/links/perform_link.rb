module Links
  class PerformLink
    def self.call(link)
      new.call(link)
    end

    def call(link)
      parser_const = Parsers::ParserChooser.call(link)
      parser_item = parser_const.call(link.link)

      return [AttachLinkItem.call(link, parser_item), nil] if link.link_items.empty?

      diff = item_data_differs?(link, parser_item)
      return [AttachLinkItem.call(link, parser_item), diff] unless diff.nil?

      [nil, nil]
    end

    private

    def item_data_differs?(link, parser_item)
      Parsers::ParserItemDiffers.call(Parsers::ConvertToParserItem.call(link.active_link_item), parser_item)
    end
  end
end