# frozen_string_literal: true

# poll model
class MyPoll < ActiveRecord::Base
  belongs_to :user
  has_many :questions

  validates :title, presence: true, length: { minimum: 10 }
  validates :description, presence: true, length: { minimum: 20 }
  validates :expires_at, presence: true
  validates :user, presence: true

  def active?
    expires_at > DateTime.now
  end

  def class_name
    name = self.class.name.underscore
    name.pluralize.downcase
  end
end
