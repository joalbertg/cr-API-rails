# frozen_string_literal: true

json.type resource.class_name
json.id resource.id
json.attributes resource.attributes.except('created_at', 'updated_at')
