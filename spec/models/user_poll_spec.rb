require 'rails_helper'

RSpec.describe UserPoll, type: :model do
  it { should validate_presence_of :user }
  it { should validate_presence_of :my_poll }

  describe 'self.custom_find_or_create' do
    it 'create a new record with a new poll and a new user' do
      user = FactoryBot.create(:user)
      my_poll = FactoryBot.create(:my_poll)

      expect { UserPoll.custom_find_or_create(my_poll, user) }.to change(UserPoll, :count).by(1)
    end

    it 'find a record with the same poll and user' do
      user_poll = FactoryBot.create(:user_poll)

      expect do
        UserPoll.custom_find_or_create(user_poll.my_poll, user_poll.user)
      end.to change(UserPoll, :count).by(0)
    end
  end
end
