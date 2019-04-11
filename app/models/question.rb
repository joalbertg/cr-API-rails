# frozen_string_literal: true

# question model
class Question < ActiveRecord::Base
  belongs_to :my_poll

  validates :description, presence: true
  validates :description, presence: true, length: { minimum: 10 }
end
