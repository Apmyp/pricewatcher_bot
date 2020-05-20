# frozen_string_literal: true

module Parsers
  class SonycenterParser < Parser
    class << self
      def host
        'sonycenter.md'
      end

      def paths
        [
          %r{/[^\/]*/shop/[^\/]*/?}
        ]
      end
    end

    private

    def name
      doc.at("meta[property='og:title']").try(:to_h).try(:fetch, 'content')
         .strip
    end

    def image
      doc.at("meta[property='og:image']").try(:to_h).try(:fetch, 'content')
    end

    def price
      if sale_price.to_i.positive?
        sale_price
      else
        regular_price
      end
    end

    def regular_price
      wrapper = doc.css('p.price')
      return if wrapper.blank?

      doc.css('p.price .woocommerce-Price-amount.amount')
         .first
         .text
         .gsub(' ', '')
         .gsub(/lei$/, '')
         .strip
    end

    def sale_price
      wrapper = doc.css('p.price.price-on-sale')
      return if wrapper.blank?

      doc.css('p.price.price-on-sale ins .woocommerce-Price-amount.amount')
         .first
         .text
         .gsub(' ', '')
         .gsub(/lei$/, '')
         .strip
    end

    def currency
      'MDL'
    end

    def availability
      true
    end
  end
end
