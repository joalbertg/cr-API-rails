FactoryBot.define do
  factory :my_app do
    association :user, factory: :user
    title { "MyString" }
    # app_id { "MyString" }
    javascript_origins { "MyString" }
    # secret_key { "MyString" }
  end
end
