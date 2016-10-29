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
