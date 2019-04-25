# frozen_string_literal: true

# json.extract! @user, :id, :name, :email
# json.extract! @token, :token

json.partial! 'api/v1/resource', resource: @user
