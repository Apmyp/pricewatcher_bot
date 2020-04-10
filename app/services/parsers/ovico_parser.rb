# frozen_string_literal: true

module Parsers
  class OvicoParser < Parser
    class << self
      def host
        'ovico.md'
      end

      def paths
        [
          %r{/[^\/]*/[^\/]*}
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
                 rescue OpenURI::HTTPError => error
                   raise Parsers::NotOkException unless error.io.status[0] == "500"

                   error.io.read
                 rescue
                   raise Parsers::NotOkException
                 end
    end
  end
end
