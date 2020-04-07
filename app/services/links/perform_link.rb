# frozen_string_literal: true

module Links
  class PerformLink
    def self.call(*args)
      new(*args).call
    end

    def initialize(link)
      @link = link
    end

    def call
      if link.link_items.empty?
        return [AttachLinkItem.call(link, parser_item), nil]
      end

      diff = item_data_differs?(link, parser_item)
      return [AttachLinkItem.call(link, parser_item), diff] unless diff.nil?

      [nil, nil]
    end

    private

    attr_reader :link

    def parser_item
      @parser_item ||= begin
                         parser_const = Parsers::ParserChooser.call(link)
                         parser_const.call(link.link)
                       rescue NotOkException
                         logger.info("[link:#{link.id}][host:#{link.host}] "\
'Link unreachable, status is not OK')
                         raise
                       end
    end

    def item_data_differs?(link, parser_item)
      converted_li = Parsers::ConvertToParserItem.call(link.active_link_item)
      Parsers::ParserItemDiffers.call(converted_li, parser_item)
    end
  end
end
