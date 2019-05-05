# frozen_string_literal: true

# json.array! @polls, :id, :title, :description, :user_id, :expires_at
# j son.array! @polls do |poll|
#   json.partial! 'api/v1/resource', resource: poll
# end
json.partial! partial: 'api/v1/resource', collection: @polls, as: :resource
