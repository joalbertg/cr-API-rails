# frozen_string_literal: true

# json.extract! @question, :id, :description
json.partial! 'api/v1/resource', resource: @question
