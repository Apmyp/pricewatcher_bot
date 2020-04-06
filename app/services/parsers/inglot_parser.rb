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
      doc.at("meta[property='og:title']")['content']
    end

    def image
      doc.at("meta[property='og:image']")['content']
    end

    def price
      doc.at("meta[property='product:price:amount']")['content']
    end

    def currency
      doc.at("meta[property='product:price:currency']")['content']
    end

    def availability
      true
    end
  end
end
