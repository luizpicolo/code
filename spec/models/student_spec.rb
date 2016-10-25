require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:responsible) }
    it { should validate_presence_of(:contact_responsible) }
    it { should validate_presence_of(:date_enrolment) }
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

  describe '#status' do
    context 'then self status nil' do
      subject(:student){ FactoryGirl.build(:student, status: nil) }

      it 'returns false' do
        expect(student.status).to eq(false)
      end
    end
  end
end
