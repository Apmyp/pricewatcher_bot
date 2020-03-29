FactoryBot.define do
  factory :telegram_user do
    external_id { 1 }
    first_name { "MyString" }
    username { "MyString" }
    language_code { "MyString" }
    raw_data { "" }
  end
end
