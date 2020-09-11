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
      try_selectors(["meta[property='og:title']", 'div > h1'])
        &.gsub(/\|\sSephora/, '')
        &.strip
    end

    def image
      img = doc.at("meta[property='og:image']")
               .try(:to_h)
               .try(:fetch, 'content')
      "https://#{self.class.host}#{img}"
    end

    def price
      if sale_price.to_i.positive?
        sale_price
      else
        regular_price
      end
    end

    def regular_price
      css = 'span[data-at="price"]'
      el = doc.css(css).first
      el.text.strip.sub(/^\$/, '').to_i.to_s if el.present?
    end

    def sale_price
      css = 'span[data-at="sale_price"]'
      el = doc.css(css).first
      el.text.strip.sub(/^\$/, '').to_i.to_s if el.present?
    end

    def currency
      'USD'
    end

    def availability
      true
    end
  end
end
