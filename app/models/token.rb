# frozen_string_literal: true

# token user
class Token < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------
  belongs_to :user

  def active?
    expires_at > DateTime.now
  end

  class << self
    attr_reader :token_data

    def token?(token_str)
      @token_data = Token.find_by(token: token_str) if token_str

      token_data.try(:active?) ? true : false
    end

    def user
      token_data.user
    end
  end
end
