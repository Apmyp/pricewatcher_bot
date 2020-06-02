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
      fetch
    end

    protected

    attr_reader :link

    def fetch
      @fetch ||= begin
                   raise Parsers::NotOkException unless fetch_status_code == 200

                   fetch_body
                 rescue OpenURI::HTTPError, StandardError
                   raise Parsers::NotOkException
                 end
    end

    def doc
      @doc ||= Nokogiri::HTML(fetch)
    end

    def fetch_uri
      @fetch_uri ||= URI.open(link, 'User-Agent' => USER_AGENT)
    end

    def fetch_body
      @fetch_body ||= fetch_uri.read
    end

    def fetch_status_code
      @fetch_status_code ||= fetch_uri.status[0].to_i
    end

    def normalize_number(number)
      number.try(:strip).try(:to_i).try(:to_s)
    end

    def try_selectors(selectors)
      selectors.map do |selector|
        el = doc.css(selector)
        next nil if el.blank?

        first_el = el.first
        next nil if first_el.blank?

        get_el_content(first_el)
      end.select(&:present?).first
    end

    def get_el_content(element)
      if element.try(:to_h).try(:fetch, 'content', nil).present?
        element.try(:to_h).try(:fetch, 'content')
      elsif element.try(:text).present?
        element.try(:text)
      end
    end
  end
end
