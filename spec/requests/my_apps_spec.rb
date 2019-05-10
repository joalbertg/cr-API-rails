require 'rails_helper'

RSpec.describe 'MyApps', type: :request do
  let(:my_app) { FactoryBot.create(:my_app) }

  describe 'GET /my_apps' do
    xit 'works! (now write some real specs)' do
      get my_apps_path, secret_key: my_app.secret_key
      expect(response).to have_http_status(200)
    end
  end
end
