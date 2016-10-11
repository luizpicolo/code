# frozen_string_literal: true
require 'rails_helper'

RSpec.describe IncidentsController, type: :controller do
  describe 'without being logged in' do
    subject { controller }

    # TODO: implement session controller
    # it_behaves_like 'LoggedOut'
    describe 'GET' do
      %w(index new create).each do |action|
        it "#{action} redirects to login" do
          get action

          expect(response).to redirect_to('/users/sign_in')
          expect(flash[:alert]).to eql('Para continuar, efetue login ou registre-se.')
        end
      end
    end
  end

  describe 'with a user logged in' do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    describe 'GET #index' do
      it 'responds successfully with an HTTP 200 status code' do
        get :index

        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template('index')
      end
    end

    describe "GET #show" do
      it "assigns the requested incident to @incident" do
        incident = FactoryGirl.create(:incident, user: user)
        get :show, id: incident
        assigns(:incident).should eq(incident)
      end

      it "renders the #show view" do
        get :show, id: FactoryGirl.create(:incident, user: user)
        response.should render_template :show
      end
    end

    describe 'GET #new' do
      before(:each) do
        get :new
      end

      it 'responds successfully with an HTTP 200 status code' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'renders the new template' do
        expect(response).to render_template('new')
      end
    end

    describe 'GET #update' do
      let!(:incident) { FactoryGirl.create :incident, user: user }
      let(:valid_params) { { description: 'A new description' } }

      it 'accepts changes' do
        put :update, id: incident.id, incident: valid_params
        expect(response).to redirect_to incident
      end
    end
  end
end

