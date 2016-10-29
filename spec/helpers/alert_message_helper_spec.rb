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

require 'spec_helper'

describe AlertMessageHelper do
  context 'valid resource' do
    let(:resource){ FactoryGirl.create(:student) }
    before do
      assign(:resource, resource)
    end

    describe '#show_messages' do
      it 'returns no error messages' do
        expect(helper.show_messages).to be_empty
      end
    end
  end

  context 'invalid resource' do
    let(:resource){ Student.new }
    before do
      resource.valid?
      assign(:resource, resource)
    end

    describe '#show_messages' do
      it 'generates a HTML with errors messages' do
        expect(helper.show_messages).to be_instance_of(ActiveSupport::SafeBuffer)
      end

      it 'includes error messages div#alert-danger' do
        expect(helper.show_messages).to match /alert-danger/
      end
    end
  end
end
