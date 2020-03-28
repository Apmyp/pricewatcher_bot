module Links
  class PerformLink
    def self.call(link)
      new.call(link)
    end

    def call(link)
      parser = Parsers::ParserChooser.call(link)
      parser_item = parser.call(link.link)
      AttachLinkItem.call(link, parser_item)
    end
  end
end