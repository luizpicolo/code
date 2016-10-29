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

RSpec.describe SchoolPerformacesController, type: :controller do
  describe 'without being logged in' do
    subject { controller }

    describe 'GET' do
      context 'with params[:search]' do
        let(:user) { FactoryGirl.create(:user, admin: true) }
        before { sign_in user }

        it 'assigns @school_performaces with name searched for params[:search]' do
          first_school_performace = FactoryGirl.create(:school_performace, user: user)

          get :index, method: :get, params: { search: user.name }
          expect(assigns(:school_performaces)).to eq([first_school_performace])
        end
      end
    end
  end
end
