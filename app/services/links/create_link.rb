module Links
  class CreateLink
    require 'uri'

    def self.call(user, raw_link)
      new.call(user, raw_link)
    end

    def call(user, raw_link)
      normalized_raw_link = raw_link.sub(/^\/\//, '').sub(/\.$/, '')
      uri = URI.parse(normalized_raw_link)
      uri = URI.parse("http://#{normalized_raw_link}") if uri.scheme.nil?

      host_without_www = uri.host.start_with?('www.') ? uri.host[4..-1] : uri.host

      Link.create!(
          telegram_user: user,
          hash_id: Nanoid.generate,
          link: raw_link,
          scheme: uri.scheme,
          host: host_without_www,
          status: :active
      )
    end
  end
end