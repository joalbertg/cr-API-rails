require 'rails_helper'

RSpec.describe 'MyApps', type: :request do
  let(:user1) { create(:user) }
  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  describe 'GET /my_apps' do
    xit 'works! (now write some real specs)' do
      get my_apps_path, secret_key: my_app.secret_key
      expect(response).to have_http_status(200)
    end
  end
end
