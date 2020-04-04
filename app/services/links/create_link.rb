# frozen_string_literal: true

module Links
  class PathNotFoundException < RuntimeError; end

  class CreateLink
    require 'uri'

    NANOID_ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyz'

    def self.call(*args)
      new.call(*args)
    end

    def call(user, raw_link)
      uri = normalized_raw_link(raw_link)
      host_without_www = host_without_www(uri)

      Link.create!(
        telegram_user: user,
        hash_id: Nanoid.generate(alphabet: NANOID_ALPHABET),
        link: uri.to_s,
        scheme: uri.scheme,
        host: host_without_www,
        status: :active
      )
    end

    private

    def host_without_www(uri)
      if uri.host.start_with?('www.')
        uri.host[4..-1]
      else
        uri.host
      end
    end

    def normalized_raw_link(raw_link)
      link = raw_link.sub(%r{^//}, '').sub(/\.$/, '')
      uri = URI.parse(link)

      if uri.scheme.nil?
        link = "http://#{link}"
        uri = URI.parse(link)
      end

      raise PathNotFoundException if uri.path.size.zero?

      uri
    end
  end
end
