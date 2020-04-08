# frozen_string_literal: true

FactoryBot.define do
  factory :request do
    status { 1 }
    html { 'MyString' }
    link
  end
end
