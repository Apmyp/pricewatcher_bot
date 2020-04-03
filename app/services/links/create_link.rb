module Links
  class PathNotFoundException < ::Exception; end

  class CreateLink
    require 'uri'

    NANOID_ALPHABET = '0123456789abcdefghijklmnopqrstuvwxyz'

    def self.call(user, raw_link)
      new.call(user, raw_link)
    end

    def call(user, raw_link)
      normalized_raw_link = raw_link.sub(/^\/\//, '').sub(/\.$/, '')
      uri = URI.parse(normalized_raw_link)
      uri = URI.parse("http://#{normalized_raw_link}") if uri.scheme.nil?

      raise PathNotFoundException.new if uri.path.size.zero?

      host_without_www = uri.host.start_with?('www.') ? uri.host[4..-1] : uri.host

      Link.create!(
          telegram_user: user,
          hash_id: Nanoid.generate(alphabet: NANOID_ALPHABET),
          link: raw_link,
          scheme: uri.scheme,
          host: host_without_www,
          status: :active
      )
    end
  end
end