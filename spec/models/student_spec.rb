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

  describe '#show_name' do
    subject(:student){ FactoryGirl.create(:student) }
    it 'shows id and name' do
      output = student.id.to_s + ' - ' + student.name
      expect(student.show_name).to eq(output)
    end
  end
end
