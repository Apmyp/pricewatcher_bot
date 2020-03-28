module Links
  class PerformLink
    def self.call(link)
      new.call(link)
    end

    def call(link)
      parser_const = Parsers::ParserChooser.call(link)
      parser_item = parser_const.call(link.link)
      if link.link_items.empty? || item_data_differs?(link, parser_item)
        AttachLinkItem.call(link, parser_item)
      end
    end

    private

    def item_data_differs?(link, parser_item)
      Parsers::ParserItemDiffers.call(Parsers::ConvertToParserItem.call(link.active_link_item), parser_item)
    end
  end
end