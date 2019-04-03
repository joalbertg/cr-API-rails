# frozen_string_literal: true

# handling errors
module ErrorHandler
  extend ActiveSupport::Concern

  def param_missing?(key)
    render json: { error: "#{key} param is missing" } unless params[key]
  end
end
