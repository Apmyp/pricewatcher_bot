# frozen_string_literal: true

module Parsers
  class OvicoParser < Parser
    class << self
      def host
        'ovico.md'
      end

      def paths
        [
          %r{/[^\/]*/[^\/]*/?}
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
      doc.css('meta[itemprop="price"]')
         .first['content']
         .strip
         .to_i
         .to_s
    end

    def currency
      'MDL'
    end

    def availability
      availability = doc.css('meta[itemprop="availability"]')
                        .first['content']
                        .strip

      availability == 'InStock'
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
