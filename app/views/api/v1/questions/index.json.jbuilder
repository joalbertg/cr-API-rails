# frozen_string_literal: true

#json.array! @questions, :id, :description
json.partial! partial: 'api/v1/resource', collection: @questions, as: :resource
