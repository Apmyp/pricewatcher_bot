# frozen_string_literal: true

module Parsers
  class DarwinParser < Parser
    class << self
      def host
        'darwin.md'
      end

      def paths
        [
          %r{/[^\/_]*_[^\/]*\.html}
        ]
      end
    end

    private

    def name
      doc.at("meta[property='og:title']")['content']
         .gsub(' - на darwin.md', '')
         .gsub(' - pe darwin.md', '')
         .strip
    end

    def image
      doc.at("meta[property='og:image']")['content']
    end

    def price
      doc.xpath('//*[@id="main"]/section[3]/div/'\
                'div/div[3]/div[2]/div[2]/div/div[2]/h2')
         .text
         .gsub(' ', '')
         .strip
         .to_i
         .to_s
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
