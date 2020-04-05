# frozen_string_literal: true

module Parsers
  class ExampleParser < Parser
    class << self
      def host
        'example.com'
      end

      def paths
        [
            %r{[^/]*}
        ]
      end
    end

    def call(link)
      html = fetch(link)
      doc = parse(html)

      ParserItem.new(
          name: doc.at("meta[property='og:title']")['content'],
          image: doc.at("meta[property='og:image']")['content'],
          price: doc.at("meta[property='product:price:amount']")['content'],
          currency: doc.at("meta[property='product:price:currency']")['content'],
          availability: availability(doc)
      )
    end

    private

    def availability(doc)
      doc.at("meta[property='product:availability']")['content']
          .to_s == 'in stock'
    end
  end
end
