# frozen_string_literal: true

# json.extract! @poll, :id, :title, :description, :user_id, :expires_at
# json.partial! 'api/v1/resource', resource: @poll
json.partial! 'api/v1/resource', resource: @poll
