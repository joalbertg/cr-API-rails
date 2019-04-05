# frozen_string_literal: true

# handling errors
module ErrorHandler
  extend ActiveSupport::Concern

  MSG = { param: 'param is missing',
          token: 'Invalid token' }.freeze

  def error_message(type, *value)
    # value = param_name || status

    message = MSG[type.to_sym]
    message = "#{value.first} " + message if type.eql?('param')
    message = { error: message }
    message[:status] = value.first if type.eql?('token')

    render json: message
  end
end
