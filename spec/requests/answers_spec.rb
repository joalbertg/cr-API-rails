# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::AnswersController, type: :request do
  # let(:my_app) { FactoryBot.create(:my_app) }
  let(:user1) { create(:user) }

  let(:valid_attributes) { attributes_for(:my_app).merge(user: user1) }
  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  before :each do
    @token = TokenService.new(user: FactoryBot.create(:user)).object
    @poll = FactoryBot.create(:poll_with_questions, user: @token.user)
    @question = @poll.questions[0]
  end

  let(:valid_params) { { description: 'Ruby', question_id: @question.id } }

  # -- create ---------------------------------------------------------------
  describe 'POST /polls/:poll_id/answers' do
    context 'valid user' do
      before :each do
        post api_v1_poll_answers_path(@poll), answer: valid_params, token: @token.token, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(200) }

      it 'new answer +1' do
        expect do
          post api_v1_poll_answers_path(@poll),
               answer: valid_params,
               token: @token.token,
               secret_key: my_app.secret_key
        end.to change(Answer, :count).by(1)
      end

      it 'respond with the answer created' do
        json = JSON.parse(response.body)['data']['attributes']
        expect(json['id']).to eq(Answer.last.id)
        expect(json['description']).to eq(valid_params[:description])
      end
    end

    context 'invalid user' do
    end

    context 'missing params' do
      before :each do
        post api_v1_poll_answers_path(@poll), secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(401) }

      it 'respond with the errors' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end

  # -- update ---------------------------------------------------------------
  describe 'PUT/PATCH /polls/:poll_id/answers/:id' do
    before :each do
      @answer = FactoryBot.create(:answer, question: @question)
      @answer.description = 'New answer'
      put api_v1_poll_answer_path(@poll, @answer),
          answer: @answer.as_json,
          token: @token.token,
          secret_key: my_app.secret_key
    end

    it { expect(response).to have_http_status(200) }

    it 'update the indicated data' do
      @answer.reload # optional
      json = JSON.parse(response.body)['data']['attributes']
      expect(json['description']).to eq(@answer.description)
    end
  end

  # -- delete ---------------------------------------------------------------
  describe 'DELETE /polls/:poll_id/answers/:id' do
    before :each do
      @answer = FactoryBot.create(:answer, question: @question)
    end

    it 'ok' do
      delete api_v1_poll_answer_path(@poll, @answer), token: @token.token, secret_key: my_app.secret_key
      expect(response).to have_http_status(200)
    end

    it 'eliminate the answer' do
      delete api_v1_poll_answer_path(@poll, @answer), token: @token.token, secret_key: my_app.secret_key
      expect(Answer.where(id: @answer.id)).to be_empty
    end

    it 'reduces the count of answers in -1' do
      expect do
        delete api_v1_poll_answer_path(@poll, @answer), token: @token.token, secret_key: my_app.secret_key
      end.to change(Answer, :count).by(-1)
    end
  end
end
