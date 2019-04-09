# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:attributes) { %i[email uid provider] }

  context 'validations' do
    it { attributes.each { |attr| should validate_presence_of(attr) } }
    it { should_not allow_value('liss@co-digo').for(:email) }
    it { should allow_value('liss@ab-codigo.com').for(:email) }
    it { should have_many(:tokens) }
    it { should have_many(:my_polls) }
  end

  context 'user_provider_uid' do
    it 'create if the user not exist' do
      expect do
        User.from_omniauth(uid: '12345',
                           provider: 'facebook',
                           info: { email: 'liss@abcd-codigo.com',
                                   name: 'Liss' })
      end.to change(User, :count).by(1)
    end

    it 'find if the user exist' do
      user = FactoryBot.create(:user)
      expect do
        User.from_omniauth(uid: user.uid,
                           provider: user.provider,
                           info: { email: user.email,
                                   name: user.name })
      end.to change(User, :count).by(0)
    end

    it 'return existing user' do
      user = FactoryBot.create(:user)
      expect(
        User.from_omniauth(uid: user.uid, provider: user.provider)
      ).to eq(user)
    end
  end
end
