# frozen_string_literal: true

# =
FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    sequence(:email) { |n| "liss_#{n}@factorybx.bcom" }
    provider { 'github' }
    uid { 'ujkhsvksdv35gfd' }
  end
end
