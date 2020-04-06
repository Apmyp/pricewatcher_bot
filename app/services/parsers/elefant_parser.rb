# frozen_string_literal: true

module Parsers
  class ElefantParser < Parser
    class << self
      def host
        'elefant.md'
      end

      # rubocop:disable Layout/LineLength
      def paths
        [
          %r{^/[^\/]*_[0-9a-f]{8}\b-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-\b[0-9a-f]{12}$/?}
        ]
      end
      # rubocop:enable Layout/LineLength
    end

    private

    def name
      doc.css('p.sticky-title span.sticky-brand').first.text
    end

    def image
      doc.css('img[data-large][data-type="L"]').first['data-large']
    end

    def price
      css = '[data-testing-id="current-price"][data-price-currencymnemonic]'
      doc.css(css).first.text.strip.sub(/\slei$/, '').gsub(',', '.')
    end

    def currency
      css = '[data-testing-id="current-price"][data-price-currencymnemonic]'
      doc.css(css).first['data-price-currencymnemonic']
    end

    def availability
      true
    end
  end
end
