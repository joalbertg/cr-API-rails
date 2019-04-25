# frozen_string_literal: true

# json.array! @polls, :id, :title, :description, :user_id, :expires_at
json.array! @polls do |poll|
  json.type MyPoll.name.downcase
  json.id poll.id
  json.attributes poll.attributes.except('created_at', 'updated_at')
end
