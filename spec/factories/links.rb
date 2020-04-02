FactoryBot.define do
  factory :link do
    telegram_user
    link { "http://example.com" }
    scheme { "http" }
    host { "example.com" }
    status { :active }
  end
end
