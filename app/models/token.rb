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
    loop do
      self.token = SecureRandom.hex
      break if Token.where(token: token).empty?
    end

    self.expires_at ||= 1.month.from_now
  end
end
