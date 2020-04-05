# frozen_string_literal: true

module Links
  class ValidationException < RuntimeError; end

  class CreateLink
    require 'uri'

    NANOID_ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyz'

    def self.call(*args)
      new(*args).call
    end

    def initialize(user, raw_link)
      @user = user
      @raw_link = raw_link
    end

    def call
      Link.create!(
        telegram_user: user,
        hash_id: Nanoid.generate(alphabet: NANOID_ALPHABET),
        link: normalized_uri.to_s,
        scheme: normalized_uri.scheme,
        path: normalized_uri.path,
        host: host_without_www,
        status: :active
      )
    end

    private

    attr_reader :user, :raw_link

    def host_without_www
      @host_without_www ||= begin
                              if normalized_uri.host.start_with?('www.')
                                normalized_uri.host[4..-1]
                              else
                                normalized_uri.host
                              end
                            end
    end

    def normalized_uri
      @normalized_uri ||= begin
                            link = raw_link.sub(%r{^//}, '').sub(/\.$/, '')
                            uri = URI.parse(link)

                            if uri.scheme.nil?
                              link = "http://#{link}"
                              uri = URI.parse(link)
                            end

                            uri
                          end
    end
  end
end
