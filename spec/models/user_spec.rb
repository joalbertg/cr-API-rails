require 'rails_helper'

RSpec.describe User, type: :model do
  let(:attributes) { %i[email uid provider] }

  context 'validations' do
    it { attributes.each { |attr| should validate_presence_of(attr) } }
    it { should_not allow_value('liss@co-digo').for(:email) }
    it { should allow_value('liss@ab-codigo.com').for(:email) }
  end
end
