# frozen_string_literal: true

# json.extract! @answer, :id, :description, :question_id
json.partial! 'api/v1/resource', resource: @answer
