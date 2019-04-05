# frozen_string_literal: true

# =
class ApiV1Controller < ApplicationController
  include ErrorHandler

  before_action :authenticate

  protected

  def authenticate
    return error_message('token', :unauthorized) unless Token.find_token(params[:token])

    @current_user = Token.token_data.user
  end
end
