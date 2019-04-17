# frozen_string_literal: true

# = api controller
class ApiV1Controller < ApplicationController
  include ErrorHandler

  # before_action :authenticate

  protected

  def authenticate
    return render error_message('token', :unauthorized) unless Token.token?(params[:token])

    @current_user = Token.user
  end

  def authenticate_owner(owner)
    render(error_message('record', :unauthorized)) unless owner == @current_user
  end
end
