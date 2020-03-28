FactoryBot.define do
  factory :link do
    link { "http://example.com" }
    scheme { "http" }
    host { "example.com" }
    status { :active }
  end
end
