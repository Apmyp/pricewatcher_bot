# frozen_string_literal: true

module Parsers
  class MakeupParser < Parser
    class << self
      def host
        'makeup.md'
      end

      def paths
        [
          %r{/[^\/]*/product/\d+/?},
          %r{/product/\d+/?}
        ]
      end
    end

    private

    def name
      doc.css('div[itemprop="name"]').first.text.strip
    end

    def image
      doc.at("meta[property='og:image']")['content']
    end

    def price
      doc.css('span[itemprop="price"]')
         .first
         .text
         .strip
    end

    def currency
      doc.css('meta[itemprop="priceCurrency"]').first['content'].strip
    end

    def availability
      availability = doc.css('[itemprop="availability"]')
                        .first['href']
                        .strip

      availability == 'https://schema.org/InStock'
    end
  end
end
