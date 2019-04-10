# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::MyPollsController, type: :request do
  describe 'GET /polls' do
    before :each do
      FactoryBot.create_list(:my_poll, 10)
      get '/api/v1/polls'
    end

    it { have_http_status(200) }
    it 'send the list of polls' do
      json = JSON.parse(response.body)
      expect(json.length).to eq(MyPoll.count)
    end
  end

  describe 'GET /polls/:id' do
    before :each do
      @poll = FactoryBot.create(:my_poll)
      get "/api/v1/polls/#{@poll.id}"
    end

    it { have_http_status(200) }
    it { expect(response).to have_http_status(200) }

    it 'send the requested poll' do
      json = JSON.parse(response.body)
      expect(json['id']).to eq(@poll.id)
    end

    it 'send the attributes of the poll' do
      json = JSON.parse(response.body)
      attributes = @poll.attributes.except('created_at', 'updated_at').symbolize_keys

      expect(json.keys).to contain_exactly('id', 'title', 'description', 'expires_at', 'user_id')
      expect(json.keys.map(&:to_sym)).to match_array(attributes.keys)
    end
  end

  describe 'POST /polls' do
    context 'valid token' do
      before :each do
        @poll = FactoryBot.build(:my_poll)
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        # request
        post '/api/v1/polls', token: @token.token, poll: @poll.as_json
      end

      it { expect(response).to have_http_status(200) }

      it 'new poll' do
        expect do
          post '/api/v1/polls', token: @token.token, poll: @poll.as_json
        end.to change(MyPoll, :count).by(1)
      end

      it 'respond with the poll created' do
        json = JSON.parse(response.body)
        expect(json['title']).to eq('Hello MyPoll')
      end
    end

    context 'invalid token' do
      before :each do
        post '/api/v1/polls'
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
        post '/api/v1/polls', token: @token.token, poll: @poll.as_json
      end
      it { expect(response).to have_http_status(422) }

      it 'respond with the errors when saving the poll' do
        json = JSON.parse(response.body)
        expect(json.fetch('errors')).to_not be_empty
      end
    end
  end

  describe 'PATCH /polls/:id' do
    context 'valid token' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: @token.user)
        # post '/api/v1/polls/:id'
      end
    end

    context 'invalid token' do
      before :each do
        @token = TokenService.new(user: FactoryBot.create(:user)).object
        @poll = FactoryBot.create(:my_poll, user: FactoryBot.create(:user))
        # post '/api/v1/polls/:id'
      end

      it { have_http_status(200) }
    end
  end
end
