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
      doc.at("meta[property='og:title']").try(:to_h).try(:fetch, 'content')
    end

    def image
      doc.at("meta[property='og:image']").try(:to_h).try(:fetch, 'content')
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

      el.strip == 'В наличии' || el.strip == 'În stoc'
    end
  end
end
