# frozen_string_literal: true

# poll
class MyPoll < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :expires_at, presence: true

  def active?
    expires_at > DateTime.now
  end
end
