# frozen_string_literal: true

module Parsers
  class PumaMoldovaParser < Parser
    class << self
      def host
        'pumamoldova.md'
      end

      def paths
        [
          %r{/[^\/]*/shop/[^/]*/[^/]*/[^/]*/?}
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
      doc.at("meta[property='product:price:amount']")['content'].strip.to_i.to_s
    end

    def currency
      doc.at("meta[property='product:price:currency']")['content']
    end

    def availability
      doc.at("meta[property='product:availability']")['content']
         .to_s == 'in stock'
    end
  end
end
