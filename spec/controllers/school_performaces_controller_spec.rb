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
