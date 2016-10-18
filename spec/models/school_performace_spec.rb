require 'rails_helper'

RSpec.describe SchoolPerformace, type: :model do
  describe 'validates' do
    it { should validate_presence_of(:student) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:finish_date) }
    it { should validate_presence_of(:description) }
  end

  describe 'associations' do
    it { should belong_to(:student) }
    it { should belong_to(:user) }
  end

  describe '#report' do
    it 'return list for given student_id and date interval' do
      FactoryGirl.create_list(:student, 3)
      student = FactoryGirl.create(:student)
      2.times { FactoryGirl.create(:school_performace, start_date: Date.new(2016,1,1), finish_date: Date.new(2016,1,2), student: student) }
      2.times { FactoryGirl.create(:school_performace) }

      report = SchoolPerformace.report(student.id, Date.new(2016,1,1), Date.new(2016,1,2))
      expect(report.count).to eq(2)
    end
  end

  describe 'formated strings' do
      let(:school_performace) do
        FactoryGirl.create(:school_performace,
                           start_date: Date.new(2101,2,3),
                           finish_date: Date.new(2201,12,3))
      end

    it '#sdate' do
      expect(school_performace.sdate).to eq('03/02/2101')
    end

    it '#fdate' do
      expect(school_performace.fdate).to eq('03/12/2201')
    end

    it '#value_form' do
      student = FactoryGirl.create(:student, name: 'John Doe')
      school_performace.update_attribute(:student, student)

      expect(school_performace.value_form).to eq("#{student.id} - John Doe")
    end
  end
end
