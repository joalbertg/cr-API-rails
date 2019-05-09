require 'rails_helper'

RSpec.describe MyApp, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of :title }
  it { should validate_uniqueness_of(:app_id) }
  it { should validate_uniqueness_of(:secret_key) }

  it 'app_id before creating the record' do
    my_app = FactoryBot.create(:my_app)
    expect(my_app.app_id).to_not be_nil
  end

  it 'secret_key before creating the record' do
    my_app = FactoryBot.create(:my_app)
    expect(my_app.secret_key).to_not be_nil
  end

  it 'find own tokens' do
    my_app = FactoryBot.create(:my_app)
    token = TokenService.new(user: my_app.user, my_app: my_app).object

    expect(my_app.your_token?(token)).to eq(true)
  end

  it 'invalid token' do
    my_app = FactoryBot.create(:my_app)
    second_app = FactoryBot.create(:my_app)
    token = TokenService.new(user: my_app.user, my_app: second_app).object

    expect(my_app.your_token?(token)).to eq(false)
    expect(second_app.your_token?(token)).to eq(true)
  end
end
