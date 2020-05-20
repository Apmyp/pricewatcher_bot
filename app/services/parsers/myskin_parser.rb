# frozen_string_literal: true

module Parsers
  class MyskinParser < Parser
    class << self
      def host
        'myskin.md'
      end

      def paths
        [
          %r{/[^\/]*/product/[^\/]*/?}
        ]
      end
    end

    private

    def name
      doc.xpath('//*[@id="content"]/div[1]/h1')
         .try(:first)
         .try(:text)
         .try(:strip)
    end

    def image
      doc.xpath('//*[@id="imgCoverSingle"]/img')
         .try(:first)
         .try(:to_h)
         .try(:fetch, 'data-src')
         .try(:strip)
    end

    def price
      css = 'span[id*="productPrice-"]'
      doc.css(css)
         .try(:first)
         .try(:text)
         .try(:strip)
         .try(:to_i)
         .try(:to_s)
    end

    def currency
      'MDL'
    end

    def availability
      el = doc.at('//*[@id="content"]/div[2]/div[5]/div[5]')
              .try(:text)

      el == 'Есть в наличии'
    end
  end
end
