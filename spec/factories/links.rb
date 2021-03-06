# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    telegram_user
    sequence(:link) { |n| "http://example.com/path#{n}" }
    scheme { 'http' }
    host { 'example.com' }
    path { '/path' }
    status { :active }

    trait :skip_validate do
      to_create { |instance| instance.save(validate: false) }
    end
  end
end
