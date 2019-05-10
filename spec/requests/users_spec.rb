# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Api::V1::UsersController, type: :request do
  let(:user1) { create(:user) }
  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  describe 'POST /users' do
    before :each do
      auth = { provider: 'facebook', uid: '123jkfsvjk6', info: { email: 'joa@xy-code.com' } }
      post '/api/v1/users', auth: auth, secret_key: my_app.secret_key
    end

    it { expect(response).to have_http_status(200) }

    it { change(User, :count).by(1) }

    it 'respond with the user found or created' do
      json = JSON.parse(response.body)['data']['attributes']
      expect(json['email']).to eq('joa@xy-code.com')
    end

    it 'response with token' do
      token = Token.last
      expect(token.my_app).to_not be_nil
    end
  end
end
