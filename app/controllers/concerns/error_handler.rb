# frozen_string_literal: true

# handling errors
module ErrorHandler
  extend ActiveSupport::Concern

  MSG = { error: '',
          # destroy: 'You are not authorized to delete this record',
          param: 'Missing param',
          token: 'Invalid token',
          record: 'Unauthorized user to modify this record',
          delete: 'The indicated record was successfully deleted' }.freeze

  attr_reader :type, :value
  # value = param_name || status

  def error_message(type, *value)
    @type = type
    @value = value

    { json: message }
  end

  private

  def message
    @errors << MSG[type.to_sym] + param_msg.to_s
    error_msg
    status_msg

    render template: 'api/v1/errors'
  end

  def error_msg
    return '' unless type.eql?('error')

    response.status = value.first
    @errors << value.second.errors.full_messages
  end

  def param_msg
    return '' unless type.eql?('param')

    response.status = value.second
    " :#{value.first}"
  end

  def status_msg
    return '' unless type.eql?('token') || type.eql?('record') || type.eql?('delete')

    response.status = value.first
  end
end
