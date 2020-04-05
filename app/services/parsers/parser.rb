# frozen_string_literal: true

module Parsers
  class Parser
    require 'open-uri'
    require 'uri'
    require 'nokogiri'

    # rubocop:disable Layout/LineLength
    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0.3770.112 Safari/537.36'
    # rubocop:enable Layout/LineLength

    def self.call(*args)
      new(*args).call
    end

    def initialize(link)
      @link = link
    end

    def call
      ParserItem.new(
        name: name,
        image: image,
        price: price,
        currency: currency,
        availability: availability
      )
    end

    protected

    attr_reader :link

    def fetch
      @fetch ||= URI.open(link, 'User-Agent' => USER_AGENT).read
    end

    def doc
      @doc ||= Nokogiri::HTML(fetch)
    end
  end
end
