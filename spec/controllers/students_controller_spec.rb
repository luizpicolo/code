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

# frozen_string_literal: true
require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
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

        context 'without params[:search]' do
          it 'assigns @students with all students paginated' do
            get :index

            expected_students = Student.all.page(nil)
            expect(assigns(:students)).to eq(expected_students)
          end
        end

        context 'with params[:search]' do
          it 'assigns @students with students searched for params[:search]' do
            searchable_context = 'search_test'
            get :index, params: { search: searchable_context }

            expected_students = Student.search(searchable_context).page(nil)
            expect(assigns(:students)).to eq(expected_students)
          end
        end
      end

      describe "GET #show" do
        it "assigns the requested student to @student" do
          student = FactoryGirl.create(:student)
          process :show, method: :get, params: { id: student}
          expect(assigns(:student)).to eql(student)
        end

        it "renders the #show view" do
          process :show, method: :get, params: { id: FactoryGirl.create(:student)}
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

      describe 'PUT #update' do
        let!(:student) { FactoryGirl.create :student }
        let(:valid_params) { { responsible: Faker::GameOfThrones.character } }
        let(:invalid_params) { { responsible: nil } }

        context 'with valid params' do
          it 'accepts changes' do
            process :update, method: :put, params: { id: student.id, student: valid_params}
            expect(flash[:success]).to eql('Estudante atualizado com sucesso')
            expect(response).to redirect_to '/students'
          end
        end

        context 'with invalid params' do
          it 'renders the edit template' do
            put :update, params: {id: student.id, student: invalid_params}
            expect(response).to render_template(:edit)
          end

          it 'adds error to flash[:error]' do
            put :update, params: {id: student.id, student: invalid_params}

            student = assigns(:student)

            error_msg = []
            student.errors.full_messages.each do |msg|
              error_msg << "#{msg}"
            end

            expect(flash[:error]).to eq(error_msg)
          end
        end
      end

      describe 'POST #create' do
        context "with valid attributes" do
          it 'create a new student' do
            expect{
              process :create, method: :post, params: { student: {name: Faker::StarWars.character, responsible: Faker::StarWars.character, contact_responsible: Faker::Internet.email, date_enrolment: Time.zone.now - 3.month , status: true }}
            }.to change(Student,:count).by(1)
          end

          it "redirects to the Students" do
            process :create, method: :post, params: { student: {name: Faker::StarWars.character, responsible: Faker::StarWars.character, contact_responsible: Faker::Internet.email, date_enrolment: Time.zone.now - 3.month , status: true }}
            expect(response).to redirect_to Student
          end
        end

        context "with invalid attributes" do
          it "does not save the new student" do
            expect{
              process :create, method: :post, params: { student: {name: nil, responsible: nil, contact_responsible: Faker::Internet.email, date_enrolment: Time.zone.now - 3.month , status: true }}
            }.to_not change(Student,:count)
          end

          it "renders the new template" do
            process :create, method: :post, params: { student: {name: nil, responsible: nil, contact_responsible: Faker::Internet.email, date_enrolment: Time.zone.now - 3.month , status: true }}

            expect(response).to render_template(:new)
          end

          it "adds error to flash[:error]" do
            process :create, method: :post, params: { student: {name: nil, responsible: nil, contact_responsible: Faker::Internet.email, date_enrolment: Time.zone.now - 3.month , status: true }}

            student = assigns(:student)

            error_msg = []
            student.errors.full_messages.each do |msg|
              error_msg << "#{msg}"
            end

            expect(flash[:error]).to eq(error_msg)
          end
        end
      end

      describe 'DELETE #destroy' do
        let!(:student) { FactoryGirl.create :student }

        context 'successful destroy' do
          it "deletes the student" do
            expect{
              process :destroy, method: :delete, params: { id: student}
            }.to change(Student,:count).by(-1)
          end

          it "redirects to index" do
            process :destroy, method: :delete, params: { id: student}
            expect(response).to redirect_to '/students'
            expect(flash[:success]).to eql('Estudante excluído com sucesso')
          end
        end

        context 'unsuccessful destroy' do
          it "adds error to flash[:error]" do
            allow_any_instance_of(Student).to receive(:destroy).and_return(false)

            delete :destroy, params: { id: student }
            expect(flash[:error]).to eq('Erro ao excluir estudante')
          end

          it "redirects to index" do
            allow_any_instance_of(Student).to receive(:destroy).and_return(false)

            delete :destroy, params: { id: student }
            expect(response).to redirect_to students_path
          end
        end
      end
    end
  end
end

