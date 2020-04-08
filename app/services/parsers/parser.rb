# frozen_string_literal: true

module Parsers
  class NotOkException < ::StandardError; end

  class Parser
    require 'open-uri'
    require 'nokogiri'

    USER_AGENT = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_1) '\
                 'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/75.0'\
                 '.3770.112 Safari/537.36'

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

    def to_html
      fetch_body
    end

    protected

    attr_reader :link

    def fetch
      @fetch ||= begin
                   raise NotOkException unless fetch_status_code == 200

                   fetch_body
                 end
    end

    def doc
      @doc ||= Nokogiri::HTML(fetch)
    end

    private

    def fetch_uri
      @fetch_uri ||= URI.open(link, 'User-Agent' => USER_AGENT)
    end

    def fetch_body
      @fetch_body ||= fetch_uri.read
    end

    def fetch_status_code
      @fetch_status_code ||= fetch_uri.status[0].to_i
    end
  end
end
