require 'rails_helper'

feature 'Create student', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with correct data' do
    sign_in user
    create_student

    expect(page).to have_content('Estudante cadastro com sucesso')
  end
end
