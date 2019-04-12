# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    association :my_poll, factory: :my_poll
    description { '¿Cuál es tu personaje favorito en Marvel?' + Faker::Book.genre }
  end
end
