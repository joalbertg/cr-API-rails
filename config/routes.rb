# frozen_string_literal: true

# api routes
Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: :create
      resources :polls, controller: 'my_polls', except: %i[new edit] do
        resources :questions, except: %i[new edit]
        resources :answers, only: %i[create update destroy]
      end
    end
  end
end
