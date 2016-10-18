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
