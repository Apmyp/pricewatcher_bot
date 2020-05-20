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
      return [nil, nil] if parser_item.blank?

      perform_parser_item
    end

    private

    attr_reader :link

    def perform_parser_item
      if link.link_items.empty?
        return [AttachLinkItem.call(link, parser_item), nil]
      end

      diff = item_data_differs?(link, parser_item)
      return [AttachLinkItem.call(link, parser_item), diff] unless diff.nil?

      [nil, nil]
    end

    def parser_item
      @parser_item ||= begin
                         parser.call
                       rescue Parsers::NotOkException,
                              Dry::Struct::Error,
                              Parsers::ParserChooser::ParserNotFoundException
                         perform_error
                         raise
                       end
    end

    def parser
      @parser ||= begin
                    parser_const = Parsers::ParserChooser.call(link)
                    parser_const.new(link.link)
                  end
    end

    def perform_error
      request = save_request(:error)

      Links::DisableLink.call(link) if link.reload.errors_count >= 9

      Rails.logger.info("[link:#{link.id}][host:#{link.host}]"\
"[request:#{request.id}] "\
'Link unreachable, status is not OK')
    end

    def save_request(status)
      Links::CreateLinkRequest.call(
        link: link,
        status: status,
        html: parser.to_html
      )
    end

    def item_data_differs?(link, parser_item)
      converted_li = Parsers::ConvertToParserItem.call(link.active_link_item)
      Parsers::ParserItemDiffers.call(converted_li, parser_item)
    end
  end
end
