# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Token, type: :model do
  let(:user1) { create(:user) }
  let(:valid_attributes) { attributes_for(:token).merge(user: user1) }

  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'expiration' do
    it 'valid when has not expired' do
      valid_attributes[:expires_at] = (DateTime.now + 2.minute)
      token = TokenService.new(valid_attributes).object

      expect(token.active?).to eq(true)
    end

    it 'invalid when has expired' do
      valid_attributes[:expires_at] = (DateTime.now - 5.day)
      token = TokenService.new(valid_attributes).object

      expect(token.active?).to eq(false)
    end
  end
end
