# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::UsersController, type: :request do
  describe 'POST /users' do
    before :each do
      auth = { provider: 'facebook', uid: '123jkfsvjk6', info: { email: 'joa@xy-code.com' } }
      post '/api/v1/users', auth: auth
    end

    it { expect(response).to have_http_status(200) }

    it { change(User, :count).by(1) }

    it 'respond with the user found or created' do
      json = JSON.parse(response.body)['data']['attributes']
      expect(json['email']).to eq('joa@xy-code.com')
    end
  end
end
