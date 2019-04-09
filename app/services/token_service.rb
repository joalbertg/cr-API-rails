# frozen_string_literal: true

# service
class TokenService
  def initialize(params)
    @token = Token.new(params)
  end

  def create_object
    generate_token && @token.save ? true : false
  end

  def errors
    @token.errors
  end

  def object
    create_object
    @token
  end

  private

  def generate_token
    loop do
      @token.token = SecureRandom.hex
      break if Token.where(token: @token.token).empty?
    end

    @token.expires_at ||= 1.month.from_now
  end
end
