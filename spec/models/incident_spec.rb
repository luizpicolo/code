require 'rails_helper'

RSpec.describe Incident, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:date_incident) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:user) }
  end
end
