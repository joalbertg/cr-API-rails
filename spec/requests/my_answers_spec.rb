# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::MyAnswersController, type: :request do
  # let(:my_app) { FactoryBot.create(:my_app) }
  let(:user1) { create(:user) }

  let(:valid_attributes) { attributes_for(:my_app).merge(user: user1) }
  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  before :each do
    @token = TokenService.new(user: FactoryBot.create(:user), my_app: @my_app).object
    @poll = FactoryBot.create(:poll_with_questions, user: @token.user)
    question = FactoryBot.create(:question, my_poll: @poll)
    @answer = FactoryBot.create(:answer, question: question)
  end

  let(:valid_params) { { my_poll_id: @poll.id, answer_id: @answer.id, token: @token.token, secret_key: my_app.secret_key } }

  describe 'POST /polls/:poll_id/answers' do
    before :each do
      post api_v1_my_answers_path, valid_params
    end

    it { expect(response).to have_http_status(200) }

    it 'respond with the new my_answer' do
      json = JSON.parse(response.body)['data']['attributes']
      expect(json['id']).to eq(MyAnswer.last.id)
    end
  end
end



