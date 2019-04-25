# frozen_string_literal: true

# = api controller
class ApiV1Controller < ApplicationController
  include ErrorHandler

  # before_action :authenticate
  before_action :set_jbuilder_defaults

  protected

  def authenticate
    return error_message('token', :unauthorized) unless Token.token?(params[:token])

    @current_user = Token.user
  end

  def authenticate_owner(owner)
    error_message('record', :unauthorized) unless owner == @current_user
  end

  def set_jbuilder_defaults
    @errors = []
  end
end
