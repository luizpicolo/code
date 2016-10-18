require 'spec_helper'

describe ApplicationHelper do
  describe '#resource_name' do
    it 'returns the symbol :user' do
      expect(helper.resource_name).to eq(:user)
    end
  end

  describe '#resource' do
    it 'returns an existing resource' do
      user = FactoryGirl.create(:user)
      assign(:resource, user)
      expect(helper.resource).to be_instance_of(User)
      expect(helper.resource.id).to eq(user.id)
    end

    it 'returns a new user as resource' do
      expect(helper.resource).to be_instance_of(User)
      expect(helper.resource.id).to be_nil
    end
  end

  describe '#devise_mapping' do
    it 'returns a user devise_mapping' do
      expect(helper.devise_mapping).to be_instance_of(Devise::Mapping)
    end
  end
end
