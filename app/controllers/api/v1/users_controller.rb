# frozen_string_literal: true

module Api
  module V1
    # users controller
    class UsersController < ApiV1Controller
      # POST /users
      attr_reader :user

      def create
        # params = { auth: { provider: , uid: } }
        return render_message unless params[:auth]

        @user = User.from_omniauth(params.fetch(:auth))
        @token = TokenService.new(user: user).object

        render 'api/v1/users/show'
      end

      def show
        # params = { auth: { provider: , uid: } }
        return render_message unless params[:auth]

        @user = User.from_omniauth(params.fetch(:auth))
        @token = TokenService.new(user: user).object

        render 'api/v1/users/show'
      end

      private

      def render_message
        error_message('param', :auth, :unprocessable_entity)
      end
    end
  end
end
