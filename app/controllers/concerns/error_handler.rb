# frozen_string_literal: true

# handling errors
module ErrorHandler
  extend ActiveSupport::Concern

  MSG = { param: 'Missing param',
          token: 'Invalid token' }.freeze

  # responsible for storing the arguments
  Data = Struct.new(:type, :value_1)
  attr_reader :data

  def error_message(type, *value)
    @data = Data.new(type, value.first)
    # value = param_name || status
    render json: message # , status: 401 # fix status
  end

  private

  def message
    @message = MSG[data.type.to_sym] + param_msg
    @message = { errors: @message }
    status_msg
    @message
  end

  def param_msg
    return '' unless data.type.eql?('param')

    response.status = :unprocessable_entity
    " :#{data.value_1}"
  end

  def status_msg
    return '' unless data.type.eql?('token')

    response.status = :unauthorized
    @message[:status] = data.value_1
  end
end
