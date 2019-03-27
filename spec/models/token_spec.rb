# frozen_string_literal: true

require 'rails_helper'
# =
RSpec.describe Token, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
  end

  it 'should return valid when is not expired' do
    
  end
end
