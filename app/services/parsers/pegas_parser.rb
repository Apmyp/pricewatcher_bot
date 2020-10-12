# frozen_string_literal: true

module Parsers
  class PegasParser < Parser
    class << self
      def host
        'pegas.md'
      end

      def paths
        [
          %r{/[^\/]*/pages/shop/[^\/]*/[^\/]*/[^\/]*/[^\/]*/?}
        ]
      end
    end

    private

    def name
      doc.css('.p_descr h1')&.first&.text&.strip
    end

    def image
      path = doc.css('.preview img')&.first&.fetch('src', '')&.strip
      "https://#{self.class.host}#{path}" if path
    end

    def price
      doc.css('.p_descr .price strong')
         &.first
         &.text
         &.strip
         &.to_i
         &.to_s
    end

    def currency
      'MDL'
    end

    def availability
      true
    end
  end
end
