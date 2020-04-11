# frozen_string_literal: true

module Parsers
  class PegasParser < Parser
    class << self
      def host
        'pegas.md'
      end

      def paths
        [
          %r{/[^\/]*/pages/[^\/]*/[^\/]*/[^\/]*/[^\/]*/[^\/]*/?}
        ]
      end
    end

    private

    def name
      doc.css('.p_descr h1').first.text.strip
    end

    def image
      path = doc.css('.preview img').first['src'].strip
      "https://#{self.class.host}#{path}"
    end

    def price
      doc.css('.p_descr .price strong')
         .first
         .text
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

    protected

    def fetch
      @fetch ||= begin
                   fetch_body
                 rescue OpenURI::HTTPError => e
                   raise Parsers::NotOkException unless e.io.status[0] == '500'

                   e.io.read
                 rescue StandardError
                   raise Parsers::NotOkException
                 end
    end
  end
end
