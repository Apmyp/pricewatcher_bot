# frozen_string_literal: true

module Parsers
  class Parser
    require 'open-uri'
    require 'uri'
    require 'nokogiri'

    # rubocop:disable Metrics/LineLength
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.112 Safari/537.36'
    # rubocop:enable Metrics/LineLength

    def self.call(*args)
      new.call(*args)
    end

    private

    def fetch(link)
      @fetch ||= URI.open(link, 'User-Agent' => USER_AGENT).read
    end

    def parse(html)
      @parse ||= Nokogiri::HTML(html)
    end
  end
end
