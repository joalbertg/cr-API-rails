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
    context 'valid user' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: @token.user)
        @question = FactoryBot.build(:question)

        post api_v1_poll_questions_path(@poll),
             question: @question.as_json,
             token: @token.token
      end

      it { expect(response).to have_http_status(200) }

      it 'new question' do
        expect do
          post api_v1_poll_questions_path(@poll),
               question: FactoryBot.build(:question).attributes, # .as_json
               token: @token.token
        end.to change(Question, :count).by(1)
      end

      it 'respond with the question created' do
        json = JSON.parse(response.body)
        expect(json['description']).to eq(@question.description)
      end
    end

    context 'invalid user' do
      before :each do
        # post '/api/v1/polls'
        post api_v1_polls_path
      end

      it { expect(response).to have_http_status(401) }

      it 'respond with the errors' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end
end
