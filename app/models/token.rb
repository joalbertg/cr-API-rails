# frozen_string_literal: true

# token user
class Token < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------
  belongs_to :user
  belongs_to :my_app

  def active?
    expires_at > DateTime.now
  end

  class << self
    def token?(token_str)
      return false unless token_str

      @token_data = Token.find_by(token: token_str)
      # token_data.try(:active?) ? true : false
      @token_data.blank? || !@token_data.active? ? false : true
    end

    def user
      token_data.user
    end

    private

    attr_reader :token_data
  end
end
