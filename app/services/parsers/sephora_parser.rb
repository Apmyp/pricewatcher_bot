# frozen_string_literal: true

module Parsers
  class SephoraParser < Parser
    class << self
      def host
        'sephora.com'
      end

      def paths
        [
          %r{/product/[^\/]*-P\d+/?}
        ]
      end
    end

    private

    def name
      doc.at("meta[property='og:title']")['content']
         .strip
         .sub(/\s\|\sSephora$/, '')
    end

    def image
      img = doc.at("meta[property='og:image']")['content']
      "https://#{self.class.host}#{img}"
    end

    def price
      css = 'span[data-at="price"]'
      doc.css(css).first.text.strip.sub(/^\$/, '').to_i.to_s
    end

    def currency
      'USD'
    end

    def availability
      true
    end
  end
end
