FactoryBot.define do
  factory :link_item do
    link
    name { "MyString" }
    image { "MyString" }
    price { "9.99" }
    currency { "MyString" }
    availability { false }
  end
end
