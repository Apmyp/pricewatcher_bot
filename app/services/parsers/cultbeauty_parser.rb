# frozen_string_literal: true

module Parsers
  class CultbeautyParser < Parser
    class << self
      def host
        'cultbeauty.co.uk'
      end

      def paths
        [
          %r{/[^\/]*\.html}
        ]
      end
    end

    private

    def name
      doc.at("meta[property='og:title']")['content']
    end

    def image
      doc.at("meta[property='og:image']")['content']
    end

    def price
      doc.css('span[itemprop="price"]')
         .first
         .text
         .strip
         .to_i
         .to_s
    end

    def currency
      doc.css('meta[itemprop="priceCurrency"]').first['content'].strip
    end

    def availability
      availability = doc.css('[itemprop="availability"]')
                        .first['href']
                        .strip

      availability == 'http://schema.org/InStock'
    end
  end
end
