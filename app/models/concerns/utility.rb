# frozen_string_literal: true

# utility class
module Utility
  extend ActiveSupport::Concern

  def class_name
    name = self.class.name.underscore
    name.pluralize.downcase
  end
end
