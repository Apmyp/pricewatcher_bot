module Parsers
  class PumaMoldovaParser < Parser
    def call(link)
      html = fetch(link)
      doc = parse(html)

      ParserItem.new(
          name: doc.at("meta[property='og:title']")['content'],
          image: doc.at("meta[property='og:image']")['content'],
          price: doc.at("meta[property='product:price:amount']")['content'].to_i,
          currency: doc.at("meta[property='product:price:currency']")['content'],
          availability:
              doc.at("meta[property='product:availability']")['content'].to_s == "in stock",
      )
    end
  end
end