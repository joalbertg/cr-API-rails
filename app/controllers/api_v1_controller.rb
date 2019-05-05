# frozen_string_literal: true

# = api controller
class ApiV1Controller < ApplicationController
  include ErrorHandler

  # before_action :authenticate
  before_action :set_jbuilder_defaults
  before_action :cors_set_access_control_headers

  layout 'api/v1/application'

  protected

  def authenticate
    return render error_message('token', :unauthorized) unless Token.token?(params[:token])

    @current_user = Token.user
  end

  def authenticate_owner(owner)
    error_message('record', :unauthorized) unless owner.eql?(@current_user)
  end

  def set_jbuilder_defaults
    @errors = []
  end

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST,GET,PUT,DELETE,OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin,Content-Type,Accept,Authorization,Token'
  end

  def xhr_options_request
    head :ok
  end
end
