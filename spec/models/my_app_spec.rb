require 'rails_helper'

RSpec.describe MyApp, type: :model do
  let(:user1) { create(:user) }
  let(:valid_attributes) { attributes_for(:my_app).merge(user: user1) }

  let(:valid_attributes_app) { attributes_for(:my_app) }

  subject(:my_app) do
    MyAppService.new(valid_attributes_app, user1).object
  end

  it { should belong_to(:user) }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of(:app_id) }
  it { should validate_uniqueness_of(:secret_key) }

  it 'app_id before creating the record' do
    expect(my_app.app_id).to_not be_nil
  end

  it 'secret_key before creating the record' do
    expect(my_app.secret_key).to_not be_nil
  end

  it 'find own tokens' do
    token = TokenService.new(user: my_app.user, my_app: my_app).object

    expect(my_app.your_token?(token.id)).to eq(true)
  end

  it 'invalid token' do
    second_app = FactoryBot.create(:my_app)
    token = TokenService.new(user: my_app.user, my_app: second_app).object

    expect(my_app.your_token?(token.id)).to eq(false)
    expect(second_app.your_token?(token.id)).to eq(true)
  end
end
