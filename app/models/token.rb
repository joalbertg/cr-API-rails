# frozen_string_literal: true

# token
class Token < ActiveRecord::Base
  # -- Relationships --------------------------------------------------------
  belongs_to :user

  def active?
    expires_at > DateTime.now
  end

  class << self
    attr_reader :token_data

    def find_token(token_str)
      @token_data = Token.find_by(token: token_str) unless token_str.nil?
      @token_data if !@token_data.nil? && @token_data.active?
    end
  end
end
