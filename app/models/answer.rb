# frozen_string_literal: true

# answer
class Answer < ActiveRecord::Base
  include Utility

  belongs_to :question
  has_many :answers

  validates :question, presence: true
  validates :description, presence: true
end
