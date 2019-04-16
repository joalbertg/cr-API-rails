# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    association :question, factory: :question
    description { Faker::Movie.quote }
  end
end
