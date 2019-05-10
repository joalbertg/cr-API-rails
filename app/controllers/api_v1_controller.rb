# frozen_string_literal: true

# = api controller
class ApiV1Controller < ApplicationController
  include ErrorHandler

  # before_action :authenticate
  before_action :set_jbuilder_defaults
  before_action :cors_set_access_control_headers
  before_action :authenticate_app

  layout 'api/v1/application'

  protected

  def authenticate
    return error_message('token', :unauthorized) unless Token.token?(params[:token])

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

  def authenticate_app
    if params.key?(:app_id)
      error_message('app_id', :unauthorized) unless app_id?
    elsif params.key?(:secret_key)
      error_message('secret', :unauthorized) if secret_key?
    else
      error_message('app', :unauthorized)
    end
  end

  def app_id?
    @my_app = MyApp.find_by(app_id: params[:app_id])
    @my_app.nil? || !@my_app.is_valid_origin?(request.headers['origin']) ? false : true
  end

  def secret_key?
    @my_app = MyApp.find_by(secret_key: params[:secret_key])
    @my_app.nil?
  end
end
