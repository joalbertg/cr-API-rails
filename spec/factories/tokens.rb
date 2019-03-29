# frozen_string_literal: true

# =
FactoryBot.define do
  factory :token do
    association :user, factory: :user
    expires_at {} # { Faker::Time.between(5.days.ago, 1.days.ago) }
  end
end
