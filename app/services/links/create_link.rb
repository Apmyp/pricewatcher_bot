module Links
  class CreateLink
    require 'uri'

    def self.call(raw_link)
      new.call(raw_link)
    end

    def call(raw_link)
      uri = URI.parse(raw_link)

      Link.create!(
          link: raw_link,
          scheme: uri.scheme,
          host: uri.host,
          status: :active
      )
    end
  end
end