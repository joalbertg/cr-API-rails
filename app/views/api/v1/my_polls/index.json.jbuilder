# frozen_string_literal: true

json.array! @polls, :id, :title, :description, :user_id, :expires_at
