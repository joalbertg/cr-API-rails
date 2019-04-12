# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::QuestionsController, type: :request do
  before :each do
    @token = TokenService.new(user: FactoryBot.create(:user)).object
    @poll = FactoryBot.create(:poll_with_questions, user: @token.user)
  end

  describe 'GET /polls/:poll_id/questions' do
    before :each do
      get "/api/v1/polls/#{@poll.id}/questions"
    end

    it { expect(response).to have_http_status(200) }

    it 'send the list of questions' do
      json = JSON.parse(response.body)

      expect(json.length).to eq(@poll.questions.count)
    end

    it 'send description and question´s id' do
      json_array = JSON.parse(response.body)
      question = json_array[0]

      expect(question.keys).to contain_exactly('id', 'description')
    end
  end

  describe 'POST /polls/:poll_id/questions' do

  end
end
