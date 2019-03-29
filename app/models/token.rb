# frozen_string_literal: true

# token
class Token < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------
  belongs_to :user
  before_create :generate_token

  def active?
    expires_at > DateTime.now
  end

  private

  def generate_token
    self.token = SecureRandom.hex while Token.where(token: token).any?
    self.expires_at ||= 1.month.from_now
  end
end
