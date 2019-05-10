# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::QuestionsController, type: :request do
  let(:user1) { create(:user) }
  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  before :each do
    @token = TokenService.new(user: FactoryBot.create(:user)).object
    @poll = FactoryBot.create(:poll_with_questions, user: @token.user)
  end

  # -- index ---------------------------------------------------------------
  describe 'GET /polls/:poll_id/questions' do
    before :each do
      get "/api/v1/polls/#{@poll.id}/questions", secret_key: my_app.secret_key
    end

    it { expect(response).to have_http_status(200) }

    it 'send the list of questions' do
      json = JSON.parse(response.body)

      expect(json.length).to eq(@poll.questions.count)
    end

    it 'send description and question´s id' do
      json_array = JSON.parse(response.body)['data']
      question = json_array[0]['attributes']

      expect(question.keys).to contain_exactly('id', 'description', 'my_poll_id')
    end
  end

  # -- show ---------------------------------------------------------------
  describe 'GET /polls/:poll_id/questions/:id' do
    before :each do
      @question = @poll.questions[0]
      @description = @question.description
      get api_v1_poll_question_path(@poll, @question), secret_key: my_app.secret_key
    end

    it { expect(response).to have_http_status(200) }

    it 'receive the request in json' do
      json = JSON.parse(response.body)['data']['attributes']
      expect(json['description']).to eq(@description)
      expect(json['id']).to eq(@question.id)
    end
  end

  # -- create ---------------------------------------------------------------
  describe 'POST /polls/:poll_id/questions' do
    context 'valid user' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: @token.user)
        @question = FactoryBot.build(:question)

        post api_v1_poll_questions_path(@poll),
             question: @question.as_json,
             token: @token.token,
             secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(200) }

      it 'new question' do
        expect do
          post api_v1_poll_questions_path(@poll),
               question: FactoryBot.build(:question).attributes, # .as_json
               token: @token.token,
               secret_key: my_app.secret_key
        end.to change(Question, :count).by(1)
      end

      it 'respond with the question created' do
        json = JSON.parse(response.body)['data']['attributes']
        expect(json['description']).to eq(@question.description)
      end
    end

    context 'missing params' do
      before :each do
        # post '/api/v1/polls'
        post api_v1_polls_path, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(401) }

      it 'respond with the errors' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end

    context 'invalid user' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: FactoryBot.create(:user))
        @question = FactoryBot.build(:question)

        post api_v1_poll_questions_path(@poll),
             question: @question.as_json,
             token: @token.token,
             secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(401) }

      it 'respond with the errors when saving the question' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end

  # -- update ---------------------------------------------------------------
  describe 'PUT/PATCH /polls/:poll_id/questions/:id' do
    before :each do
      @question = @poll.questions[0]
      @question.description = 'Hola Mundo'
      patch api_v1_poll_question_path(@poll, @question), 
            question: @question.as_json, 
            token: @token.token,
            secret_key: my_app.secret_key
    end

    it { expect(response).to have_http_status(200) }

    it 'update the indicated data' do
      json = JSON.parse(response.body)['data']['attributes']
      expect(json['description']).to eq(@question.description)
    end
  end

  # -- delete ---------------------------------------------------------------
  describe 'DELETE /polls/:poll_id/questions/:id' do
    before :each do
      @question = @poll.questions[0]
    end

    it 'eliminate the question' do
      delete api_v1_poll_question_path(@poll, @question), 
             token: @token.token,
             secret_key: my_app.secret_key

      expect(response).to have_http_status(200)
      expect(Question.where(id: @question.id)). to be_empty
    end

    it 'reduces the count of questions in -1' do
      expect do
        delete api_v1_poll_question_path(@poll, @question),
               token: @token.token,
               secret_key: my_app.secret_key
      end.to change(Question, :count).by(-1)
    end
  end
end
