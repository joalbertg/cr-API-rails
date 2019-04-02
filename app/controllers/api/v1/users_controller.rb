# frozen_string_literal: true

module Api
  module V1
    # users
    class UsersController < ApplicationController
      # POST /users
      def create
        # params = { auth: { provider: , uid: } }
        @user = User.from_omniauth(params.fetch(:auth))
        @token = @user.tokens.create # Token.create(user: @user)

        render 'api/v1/users/show'
      end
    end
  end
end
