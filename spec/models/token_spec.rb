# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Token, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  context 'expiration' do
    it 'valid when has not expired' do
      token = FactoryBot.create(:token, expires_at: DateTime.now + 2.minute)
      expect(token.active?).to eq(true)
    end

    it 'invalid when has expired' do
      token = FactoryBot.create(:token, expires_at: DateTime.now - 5.day)
      expect(token.active?).to eq(false)
    end
  end
end
