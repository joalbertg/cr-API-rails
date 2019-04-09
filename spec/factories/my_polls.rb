# frozen_string_literal: true

FactoryBot.define do
  factory :my_poll do
    association :user, factory: :user
    expires_at { DateTime.now+10.minutes  }
    title { 'Hello MyPoll' }
    description { Faker::Lorem.sentence(10) }
  end
end
