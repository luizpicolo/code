require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:incidents) }
    it { should have_many(:school_performaces) }
  end
end
