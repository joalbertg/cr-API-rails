require 'rails_helper'

RSpec.describe User, type: :model do
  let(:attributes) { %i[email uid provider] }

  context 'validations' do
    it { attributes.each { |attr| should validate_presence_of(attr) } }
    it { should_not allow_value('liss@codigo').for(:email) }
    it { should allow_value('liss@codigo.com').for(:email) }
  end
end
