# frozen_string_literal: true

# user authentication
module UserAuthentication
  extend ActiveSupport::Concern

  def user_signed_in?
    # true if the user is logged in otherwise false
    !current_user.nil?
  end

  def current_user
    # nil or logged in user
    User.find_by_id(session[:user_id])
  end

  def authenticate_user!
    redirect_to('/', notice: 'You have to log in') unless user_signed_in?
  end
end
