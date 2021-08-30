# frozen_string_literal: true

module Parsers
  class DarwinParser < Parser
    class << self
      def host
        'darwin.md'
      end

      def paths
        [
          %r{/[^\/_]*_[^\/]*\.html},
          %r{/[^\/-]*-[^\/]*\.html}
        ]
      end
    end

    private

    def name
      doc.at("meta[property='og:title']").try(:to_h).try(:fetch, 'content')
         .gsub(' - на darwin.md', '')
         .gsub(' - pe darwin.md', '')
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
      el = doc.xpath('//*[@id="main"]/section[3]/div/div/div[3]/'\
        'div[2]/div[2]/div/div[1]/div')
      return if el.blank?

      el
        .text
        .gsub(' ', '')
        .strip
        .to_i
        .to_s
    end

    def sale_price
      el = doc.xpath('//*[@id="main"]/section[3]/div/div/div[3]/'\
        'div[2]/div[2]/div/div[2]/div')
      return if el.blank?

      el
        .text
        .gsub(' ', '')
        .strip
        .to_i
        .to_s
    end

    def currency
      'MDL'
    end

    def availability
      true
    end
  end
end
