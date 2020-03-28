module Parsers
  class Parser
    require 'open-uri'
    require 'uri'
    require 'nokogiri'

    def self.call(url)
      new.call(url)
    end

    private

    def fetch(link)
      @fetch ||= URI.open(link, 'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.112 Safari/537.36').read
    end

    def parse(html)
      @parse ||= Nokogiri::HTML(html)
    end
  end
end