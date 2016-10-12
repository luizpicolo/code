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

  %w(admin non-admin).each do |action|
    describe "with a #{action} user logged in" do
      if action == 'non-admin'
        let(:user) { FactoryGirl.create(:user, admin: false) }
      else
        let(:user) { FactoryGirl.create(:user) }
      end
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
          # get :show, id: incident
          process :show, method: :get, params: { id: incident}
          expect(assigns(:incident)).to eql(incident)
        end

        it "renders the #show view" do
          process :show, method: :get, params: { id: FactoryGirl.create(:incident, user: user)}
          expect(response).to render_template(:show)
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
          process :update, method: :put, params: { id: incident.id, incident: valid_params}
          expect(response).to redirect_to incident
        end
      end

      describe 'GET #create' do
        context "with valid attributes" do
          it 'create a new incident' do
            expect{
              process :create, method: :post, params: { incident: {student_id: FactoryGirl.create(:student).id, user_id: user.id, date_incident: Time.zone.now, description: Faker::Lorem.paragraph , soluction: Faker::Lorem.paragraph }}
              }.to change(Incident,:count).by(1)
          end

          it "redirects to the new contact" do
            process :create, method: :post, params: { incident: {student_id: FactoryGirl.create(:student).id, user_id: user.id, date_incident: Time.zone.now, description: Faker::Lorem.paragraph , soluction: Faker::Lorem.paragraph }}
            expect(response).to redirect_to Incident.last
          end
        end

        context "with invalid attributes" do
          it "does not save the new incident" do
            expect{
              process :create, method: :post, params: { incident: {student_id: FactoryGirl.create(:student).id, user_id: user.id, date_incident: nil, description: nil , soluction: nil }}
            }.to_not change(Incident,:count)
          end

          it "re-renders the new method" do
            process :create, method: :post, params: { incident: {student_id: FactoryGirl.create(:student).id, user_id: user.id, date_incident: nil, description: nil , soluction: nil }}
            expect(response).to render_template(:new)
          end
        end
      end

      describe 'DELETE destroy' do
        before :each do
          @incident = FactoryGirl.create(:incident, user: user)
        end

        it "deletes the incident" do
          expect{
            process :destroy, method: :delete, params: { id: @incident}
          }.to change(Incident,:count).by(-1)
        end

        it "redirects to contacts#index" do
          process :destroy, method: :delete, params: { id: @incident}
          expect(response).to redirect_to '/incidents'
        end
      end
    end
  end
end

