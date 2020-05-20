# frozen_string_literal: true

module Parsers
  class InglotParser < Parser
    class << self
      def host
        'inglot.md'
      end

      def paths
        [
          %r{/[^\/]*/[^/]*/[^/]*/?}
        ]
      end
    end

    private

    def name
      doc.at("meta[property='og:title']").try(:to_h).try(:fetch, 'content')
    end

    def image
      doc.at("meta[property='og:image']").try(:to_h).try(:fetch, 'content')
    end

    def price
      doc.at("meta[property='product:price:amount']")
         .try(:to_h)
         .try(:fetch, 'content')
         .strip
         .to_i
         .to_s
    end

    def currency
      doc.at("meta[property='product:price:currency']")
         .try(:to_h)
         .try(:fetch, 'content')
    end

    def availability
      true
    end
  end
end
