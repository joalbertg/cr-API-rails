# frozen_string_literal: true

require 'rails_helper'

describe TokenService do
  let(:user1) { create(:user) }
  let(:valid_attributes) { attributes_for(:token).merge(user: user1) }

  subject(:token) do
    TokenService.new(valid_attributes)
  end

  describe '#create_object' do
    it 'create token' do
      expect { token.create_object }.to change(Token, :count).by(1)
      expect(token.create_object).to be(true)
      expect(user1.tokens.count).to eq(1)
    end
  end

  describe '#object' do
    it 'object' do
      expect(token.object).to be_instance_of(Token)
      expect(token.object.user).to be_instance_of(User)
      expect(token.object).to be_valid
    end
  end

  describe '#errors' do
    it { expect(token.errors).to be_instance_of(ActiveModel::Errors) }
  end
end
