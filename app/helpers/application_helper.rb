# frozen_string_literal: true

# application helper
module ApplicationHelper
  def user_signed_in?
    # true if the user is logged in otherwise false
    !current_user.nil?
  end

  def current_user
    # nil or logged in user
    User.find_by_id(session[:user_id])
  end
end
