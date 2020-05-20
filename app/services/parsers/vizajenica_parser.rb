# frozen_string_literal: true

module Parsers
  class VizajenicaParser < Parser
    class << self
      def host
        'shop.vizaje-nica.com'
      end

      def paths
        [
          %r{/[^\/]*/[^\/]*/[^\/]*/[^\/]*/?}
        ]
      end
    end

    private

    def name
      doc.css('div.row.page_title').first.text.strip
    end

    def image
      doc.at("meta[property='og:image']").try(:to_h).try(:fetch, 'content')
    end

    def price
      doc.at('h3.displayed_price')
         .text
         .gsub(/\slei$/, '')
         .strip
         .to_i
         .to_s
    end

    def currency
      'MDL'
    end

    def availability
      true
    end
  end
end
