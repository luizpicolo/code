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
end
