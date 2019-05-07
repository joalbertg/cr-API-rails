# frozen_string_literal: true

# sessions controller
class SessionsController < ApiV1Controller
  def create
    auth = request.env['omniauth.auth']
    raise auth.to_yaml
  end
end
