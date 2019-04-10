# frozen_string_literal: true

# handling errors
module ErrorHandler
  extend ActiveSupport::Concern

  MSG = { error: '',
          param: 'Missing param',
          token: 'Invalid token',
          user: 'Unauthorized user to modify this poll' }.freeze

  attr_reader :type, :value
  # value = param_name || status

  def error_message(type, *value)
    @type = type
    @value = value

    render json: message
  end

  private

  def message
    @message = MSG[type.to_sym] + param_msg
    @message = { errors: @message }
    error_msg
    status_msg
    @message
  end

  def error_msg
    return '' unless type.eql?('error')

    response.status = value.second
    @message[:errors] = value.first.errors.full_messages
  end

  def param_msg
    return '' unless type.eql?('param')

    response.status = value.second
    " :#{value.first}"
  end

  def status_msg
    return '' unless type.eql?('token') || type.eql?('user')

    response.status = value.first
  end
end
