# frozen_string_literal: true

module Api
  module V1
    # users
    class UsersController < ApplicationController
      include ErrorHandler
      # POST /users
      def create
        # params = { auth: { provider: , uid: } }
        return if param_missing?(:auth)

        @user = User.from_omniauth(params.fetch(:auth))
        @token = @user.tokens.create

        render 'api/v1/users/show'
      end
    end
  end
end
