# frozen_string_literal: true

# poll model
class MyPoll < ActiveRecord::Base
  include Utility

  belongs_to :user
  has_many :questions
  has_many :user_polls

  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :expires_at, presence: true
  validates :user, presence: true

  def active?
    expires_at > DateTime.now
  end
end
