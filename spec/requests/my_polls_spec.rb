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
end
