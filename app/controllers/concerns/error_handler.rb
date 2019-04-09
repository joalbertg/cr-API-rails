# frozen_string_literal: true

# handling errors
module ErrorHandler
  extend ActiveSupport::Concern

  MSG = { param: 'Missing param',
          token: 'Invalid token' }.freeze

  def error_message(type, *value)
    # value = param_name || status
    render json: message(type, value), status: 401
  end

  private

  def message(type, value)
    @message = MSG[type.to_sym] + param_msg(type, value)
    @message = { error: @message }
    status_msg(type, value)
    @message
  end

  def param_msg(type, value)
    type.eql?('param') ? " :#{value.first}" : ''
  end

  def status_msg(type, value)
    @message[:status] = value.first if type.eql?('token')
  end
end
