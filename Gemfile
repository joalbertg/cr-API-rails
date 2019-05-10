# frozen_string_literal: true

source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.20.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# A modern responsive front-end framework based on Material Design
gem 'materialize-sass', '~> 1.0'
# allows  to login to Google with your ruby app
gem 'omniauth-google-oauth2', '~> 0.6.1'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks', '~> 5.2'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # console
  gem 'awesome_print', '~> 1.8'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 11.0', '>= 11.0.1'
  # configuration of local environment variables
  gem 'dotenv-rails', '~> 2.7', '>= 2.7.2'
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.1'
  gem 'faker', '~> 1.9', '>= 1.9.3'
  # pronto-
  gem 'pronto-brakeman', '~> 0.10.0', require: false
  gem 'pronto-fasterer', '~> 0.10.0', require: false
  gem 'pronto-rails_best_practices', '~> 0.10.0', require: false
  gem 'pronto-reek', '~> 0.10.0', require: false
  gem 'pronto-rubocop', '~> 0.10.0', require: false
  gem 'pry-byebug', '~> 3.7'
  # gem 'pry-nav', '~> 0.2.4'
  gem 'pry-rails', '~> 0.3.9'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'rubocop-performance', '~> 1.1'
  # matchers
  gem 'shoulda-matchers', '~> 4.0', '>= 4.0.1'
  # gem 'capybara', '~> 3.15'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :development do
  gem 'brakeman', '~> 4.5', require: false
  # Pronto is an automatic code review ruby gem
  gem 'pronto', '~> 0.10.0'
  # Automatically generate an entity-relationship diagram (ERD) for your Rails models.
  gem 'rails-erd', '~> 1.5.2', require: false
  gem 'rails_best_practices', '~> 1.19.1', require: false
  gem 'reek', '~> 5.3.0', require: false
  #  Rubocop as reference to styling rules.
  gem 'rubocop', '~> 0.67.2', require: false
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end
