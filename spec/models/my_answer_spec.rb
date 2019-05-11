require 'rails_helper'

RSpec.describe MyAnswer, type: :model do
  it { should validate_presence_of :user_poll }
  it { should validate_presence_of :answer }
  
  describe 'self.custom_update_or_create' do
    it 'create a new record with a new user_poll and a new user' do
      user_poll = FactoryBot.create(:user_poll)
      answer = FactoryBot.create(:answer)

      expect do
        MyAnswer.custom_update_or_create(user_poll, answer)
      end.to change(MyAnswer, :count).by(1)
    end

    it 'find and update a record with the same poll and user' do
      my_answer = FactoryBot.create(:my_answer)
      my_answer.update(question: my_answer.answer.question)
      
      expect do
        MyAnswer.custom_update_or_create(my_answer.user_poll, my_answer.answer)
      end.to change(MyAnswer, :count).by(0)
    end
  end
end
