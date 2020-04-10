# frozen_string_literal: true

module Parsers
  class CosmeticshopParser < Parser
    class << self
      def host
        'cosmeticshop.md'
      end

      def paths
        [
          %r{/[^\/]*/[^\/]*/\d+\-[^\/]*\.html/?}
        ]
      end
    end

    private

    def name
      doc.css('h1[itemprop="name"]').first.text.strip
    end

    def image
      doc.css('#view_full_size img[itemprop="image"]').first['src'].strip
    end

    def price
      doc.css('span[itemprop="price"]')
          .first
          .text
          .gsub(/\slei$/, '')
          .strip
    end

    def currency
      doc.css('meta[itemprop="priceCurrency"]').first['content'].strip
    end

    def availability
      true
    end
  end
end
