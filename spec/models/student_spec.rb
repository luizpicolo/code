################################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 C.O.D.E
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
################################################################################

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
