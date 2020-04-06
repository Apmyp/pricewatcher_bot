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
      doc.xpath('//*[@id="content"]/div[1]/h1').first.text
    end

    def image
      doc.xpath('//*[@id="imgCoverSingle"]/img').first['data-src']
    end

    def price
      doc.at('//*[@id="productPrice-966"]').text
    end

    def currency
      'MDL'
    end

    def availability
      el = doc.at('//*[@id="content"]/div[2]/div[5]/div[5]').text

      el == 'Есть в наличии'
    end
  end
end
