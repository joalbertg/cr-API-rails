# frozen_string_literal: true

# sessions controller
class SessionsController < ApiV1Controller
  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    # raise auth.to_yaml

    if user.persisted?
      session[:user_id] = user.id
      redirect_to '/', notice: 'you are already logged in'
    else
      redirect_to '/', notice: user.errors.full_messages.to_s
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/', notice: 'See you later!'
  end
end
