FactoryBot.define do
  factory :parser_item, class: Parsers::ParserItem do
    name { "MyString" }
    image { "MyString" }
    price { "9.99" }
    currency { "MyString" }
    availability { false }
    initialize_with { new(attributes) }
  end
end
