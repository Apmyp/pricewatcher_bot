# frozen_string_literal: true

FactoryBot.define do
  factory :link do
    telegram_user
    link { 'http://example.com' }
    scheme { 'http' }
    host { 'example.com' }
    path { '/path' }
    status { :active }
  end
end
