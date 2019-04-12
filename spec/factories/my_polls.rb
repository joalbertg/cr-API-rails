# frozen_string_literal: true

FactoryBot.define do
  factory :my_poll do
    association :user, factory: :user
    expires_at { DateTime.now + 10.minutes }
    title { 'Hello MyPoll' }
    description { Faker::Lorem.sentence(10) }

    factory :poll_with_questions do
      title { Faker::Lorem.sentence }
      description { Faker::Lorem.sentences }
      questions { build_list :question, rand(1..5) }
    end
  end
end
