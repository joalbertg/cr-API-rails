# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::MyPollsController, type: :request do
  let(:user1) { create(:user) }
  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  # -- index ---------------------------------------------------------------
  describe 'GET /polls' do
    before :each do
      FactoryBot.create_list(:my_poll, 10)
      get '/api/v1/polls', secret_key: my_app.secret_key
    end

    it { have_http_status(200) }
    it 'send the list of polls' do
      json = JSON.parse(response.body)
      expect(json['data'].length).to eq(MyPoll.count)
    end
  end

  # -- show ---------------------------------------------------------------
  describe 'GET /polls/:id' do
    before :each do
      @poll = FactoryBot.create(:my_poll)
      get "/api/v1/polls/#{@poll.id}", secret_key: my_app.secret_key
    end

    it { have_http_status(200) }
    it { expect(response).to have_http_status(200) }

    it 'send the requested poll' do
      json = JSON.parse(response.body)['data']
      expect(json['id']).to eq(@poll.id)
    end

    it 'send the attributes of the poll' do
      json = JSON.parse(response.body)['data']['attributes']
      attributes = @poll.attributes.except('created_at', 'updated_at').symbolize_keys

      expect(json.keys).to contain_exactly('id', 'title', 'description', 'expires_at', 'user_id')
      expect(json.keys.map(&:to_sym)).to match_array(attributes.keys)
    end
  end

  # -- create ---------------------------------------------------------------
  describe 'POST /polls' do
    context 'valid token' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.build(:my_poll)
        post '/api/v1/polls', token: @token.token, poll: @poll.as_json, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(200) }

      it 'new poll' do
        expect do
          post '/api/v1/polls', token: @token.token, poll: @poll.as_json, secret_key: my_app.secret_key
        end.to change(MyPoll, :count).by(1)
      end

      it 'respond with the poll created' do
        json = JSON.parse(response.body)['data']['attributes']
        expect(json['title']).to eq('Hello MyPoll')
      end
    end

    context 'invalid token' do
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

    context 'invalid params' do
      before :each do
        @poll = FactoryBot.build(:my_poll).attributes.except('title')
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        post '/api/v1/polls', token: @token.token, poll: @poll.as_json, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(422) }

      it 'respond with the errors when saving the poll' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end

  # -- update ---------------------------------------------------------------
  describe 'PATCH /polls/:id' do
    context 'valid token' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: @token.user)
        @poll.title = 'Nuevo título'
        # patch '/api/v1/polls/:id'
        patch api_v1_poll_path(@poll), token: @token.token, poll: @poll.as_json, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(200) }

      it 'update the indicated poll' do
        json = JSON.parse(response.body)['data']['attributes']
        expect(json.fetch('title')).to eq('Nuevo título')
      end
    end

    context 'invalid token' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: FactoryBot.create(:user))
        @poll.title = 'Nuevo título'
        # patch '/api/v1/polls/:id'
        patch api_v1_poll_path(@poll), token: @token.token, poll: @poll.as_json, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(401) }

      it 'non update the indicated poll' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end

  # -- delete ---------------------------------------------------------------
  describe 'DELETE /polls/:id' do
    context 'valid token' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: @token.user)
        # delete '/api/v1/polls/:id'
      end

      it 'ok' do
        delete api_v1_poll_path(@poll), token: @token.token, secret_key: my_app.secret_key
        expect(response).to have_http_status(200)
      end

      it 'delete the indicated poll' do
        expect do
          delete api_v1_poll_path(@poll), token: @token.token, secret_key: my_app.secret_key
        end.to change(MyPoll, :count).by(-1)
      end
    end

    context 'invalid token' do
      before :each do
        @poll = FactoryBot.create(:my_poll, user: FactoryBot.create(:user))
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        # delete '/api/v1/polls/:id'
        delete api_v1_poll_path(@poll), token: @token.token, secret_key: my_app.secret_key
      end

      it { expect(response).to have_http_status(401) }

      it 'non delete the indicated poll' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end
end
