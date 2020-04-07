# frozen_string_literal: true

module Parsers
  class MoonglowParser < Parser
    class << self
      def host
        'moonglow.md'
      end

      def paths
        [
          %r{/[^\/]*/products/[^\/]*/?}
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
      xpath = '//*[@id="price-product-block"]/span[@itemprop="price"]'
      doc.at(xpath)['content'].strip.to_i.to_s
    end

    def currency
      'MDL'
    end

    def availability
      el = doc.at('//*[@id="product"]/div/div/div[2]/div[1]/div[1]/div[1]').text

      el.strip == 'В наличии'
    end
  end
end
