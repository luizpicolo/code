require 'rails_helper'

feature 'delete student', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with success' do
    sign_in user

    delete_student(create_student)

    expect(page).to have_content('Estudante excluído com sucesso')
  end
end
