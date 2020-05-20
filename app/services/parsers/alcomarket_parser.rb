# frozen_string_literal: true

module Parsers
  class AlcomarketParser < Parser
    class << self
      def host
        'alcomarket.md'
      end

      def paths
        [
          %r{/[^\/]*/product/[^\/]*/?}
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
      doc.css('li .price-box.flex.unstyled li.price')
         .first
         .text
         .gsub(/\sле[й|я]$/, '')
         .strip
         .to_i
         .to_s
    end

    def currency
      'MDL'
    end

    def availability
      doc.css('li .price-box.flex.unstyled li.instock').first.present?
    end
  end
end
