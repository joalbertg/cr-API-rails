require 'rails_helper'

RSpec.describe MyPoll, type: :model do
  context 'validations' do
    let(:attributes) { %i[title description expires_at] }

    it { should belong_to(:user) }
    it { attributes.each { |attr| should validate_presence_of(attr) } }
    it { should_not allow_value('a').for(:title) }
    it { should validate_length_of(:title).is_at_least(10) }
    it { should validate_length_of(:description).is_at_least(20) }
  end

  context 'expiration' do
    it 'valid when has not expired' do
      my_poll = FactoryBot.create(:my_poll, expires_at: DateTime.now + 2.minute)
      expect(my_poll.active?).to eq(true)
    end

    it 'invalid when has expired' do
      my_poll = FactoryBot.create(:my_poll, expires_at: DateTime.now - 5.day)
      expect(my_poll.active?).to eq(false)
    end
  end
end
