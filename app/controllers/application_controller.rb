# frozen_string_literal: true

# application controller
class ApplicationController < ActionController::Base
  include UserAuthentication
  # ::API
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
end
