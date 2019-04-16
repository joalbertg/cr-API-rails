# frozen_string_literal: true

# answer
class Answer < ActiveRecord::Base
  belongs_to :question

  validates :question, presence: true
  validates :description, presence: true
end
