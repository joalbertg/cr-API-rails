FactoryBot.define do
  factory :my_poll do
    association :user, factory: :user
    expires_at { '2019-04-03 11:22:29' }
    title { 'MyStringss' }
    description { Faker::Lorem.sentence(10) }
  end
end
