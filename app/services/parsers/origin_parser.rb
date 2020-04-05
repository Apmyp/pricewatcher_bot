# frozen_string_literal: true

module Parsers
  class OriginParser < Parser
    class << self
      def host
        'origin.md'
      end

      def paths
        [
            %r{/ru/product/[^\/]*}
        ]
      end
    end

    private

    def name
      h1 = doc.xpath('//*[@id="item_info"]/div[2]/h1').first.text
      h2 = doc.xpath('//*[@id="item_info"]/div[2]/h2').first.text

      [h1, h2].join(' ')
    end

    def image
      href = doc.xpath('//*[@id="zoom1"]').first['href']

      "https://#{self.class.host}#{href}"
    end

    def price
      doc.at('//*[@id="item_info"]/div[2]/div[1]/div[1]/p').text
    end

    def currency
      doc.at('//*[@id="item_info"]/div[2]/div[1]/div[1]/span').text
    end

    def availability
      true
    end
  end
end
