# frozen_string_literal: true

# =
FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    sequence(:email) { |n| "lissy_#{n}@factorybx.bcom" }
    provider { 'github' }
    uid { Faker::Alphanumeric.alpha(10) }
  end
end
