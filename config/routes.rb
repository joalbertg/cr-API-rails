# frozen_string_literal: true

# api routes
Rails.application.routes.draw do

  get "/", to: "welcome#app", constraints: lambda{ |rqst| !rqst.session[:user_id].blank? }
  get '/', to: "welcome#index"

  resources :my_apps, except: %i[show index]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: :create
      resources :polls, controller: 'my_polls', except: %i[new edit] do
        resources :questions, except: %i[new edit]
        resources :answers, only: %i[create update destroy]
      end
      resources :my_answers, only: :create
    end
  end
  match "*unmatched", via: [:options], to: "api_v1#xhr_options_request"

  
  get '/auth/:provider/callback', to: "sessions#create"
  # get '/auth/google_oauth2/callback'

  get '/logout', to: "sessions#destroy"
end
