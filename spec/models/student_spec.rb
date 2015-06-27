require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:responsible) }
    it { should validate_presence_of(:contact_responsible) }
    it { should validate_presence_of(:date_enrolment) }
    it { should validate_presence_of(:status) }
  end

  describe 'associations' do
    it { should have_many(:school_performaces) }
    it { should have_many(:incidents) }
  end
end
