module Links
  class CreateLink
    require 'uri'

    def self.call(user, raw_link)
      new.call(user, raw_link)
    end

    def call(user, raw_link)
      uri = URI.parse(raw_link)

      Link.create!(
          telegram_user: user,
          hash_id: Nanoid.generate,
          link: raw_link,
          scheme: uri.scheme,
          host: uri.host,
          status: :active
      )
    end
  end
end