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

  describe '#value_form' do
    context 'without student' do
      subject(:incident){ Incident.new }
      it 'returns nil' do
        expect(incident.value_form).to be_nil
      end
    end

    context 'with student' do
      subject(:incident){ FactoryGirl.create(:incident) }
      it "returns student's id and name" do
        expect(incident.value_form).to be_instance_of(String)
      end
    end
  end

  context 'date methods' do
    subject(:incident){ FactoryGirl.create(:incident) }

    before do
      incident.date_incident = Date.new(2016, 8, 17)
      incident.save!
    end

    describe '#date_insident_format' do
      it 'respond with day/month/year format' do
        expect(incident.date_insident_format).to eq('17/08/2016')
      end
    end

    describe '#sdate' do
      it 'respond with day/month/year format' do
        expect(incident.sdate).to eq('17/08/2016')
      end
    end

    describe '#fdate' do
      it 'respond with day/month/year format' do
        expect(incident.fdate).to eq('17/08/2016')
      end
    end
  end

  describe '.report' do
    let(:start_date_test) { Date.new(2016, 10, 25) }
    let(:finish_date_test) { Date.new(2016, 10, 31) }

    context 'when there is NO incidents registered for the student' do
      let!(:student) { FactoryGirl.create(:student) }

      let!(:incident_of_other_student_1) { FactoryGirl.create(:incident, date_incident: Date.new(2016, 10, 26)) }
      let!(:incident_of_other_student_2) { FactoryGirl.create(:incident, date_incident: Date.new(2016, 10, 27)) }

      it { expect(Incident.report(student.id, start_date_test, finish_date_test)).to be_empty }
    end

    context 'when there is one incident registered for the student in the start date' do
      let!(:student) { FactoryGirl.create(:student) }
      let!(:incident) { FactoryGirl.create(:incident, student: student, date_incident: start_date_test) }

      it 'includes the only student\'s incident' do
        expect(Incident.report(student.id, start_date_test, finish_date_test)).to contain_exactly(incident)
      end
    end

    context 'when there is one incident registered for the student in the finish date' do
      let!(:student) { FactoryGirl.create(:student) }
      let!(:incident) { FactoryGirl.create(:incident, student: student, date_incident: finish_date_test) }

      it 'includes the only student\'s incident' do
        expect(Incident.report(student.id, start_date_test, finish_date_test)).to contain_exactly(incident)
      end
    end

    context 'when there is two incidents registered for the student in the given range date and there is two out of range' do
      let!(:student) { FactoryGirl.create(:student) }

      let!(:incident_1) { FactoryGirl.create(:incident, student: student, date_incident: Date.new(2016, 10, 24)) }
      let!(:incident_2) { FactoryGirl.create(:incident, student: student, date_incident: Date.new(2016, 10, 25)) }
      let!(:incident_3) { FactoryGirl.create(:incident, student: student, date_incident: Date.new(2016, 10, 31)) }
      let!(:incident_4) { FactoryGirl.create(:incident, student: student, date_incident: Date.new(2016, 11, 01)) }

      it 'includes only the student\'s incidents inside the given range' do
        expect(Incident.report(student.id, start_date_test, finish_date_test)).to contain_exactly(incident_2, incident_3)
      end
    end
  end
end
