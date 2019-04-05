# frozen_string_literal: true

module Api
  module V1
    # users
    class UsersController < ApiV1Controller
      # POST /users
      def create
        # params = { auth: { provider: , uid: } }
        return error_message('param', :auth) if params[:auth]

        @user = User.from_omniauth(params.fetch(:auth))
        @token = @user.tokens.create

        render 'api/v1/users/show'
      end

      def show
        # params = { auth: { provider: , uid: } }
        return error_message('param', :auth) if params[:auth].nil?

        @user = User.from_omniauth(params.fetch(:auth))
        @token = @user.tokens.create

        render 'api/v1/users/show'
      end
    end

    
  end
end
