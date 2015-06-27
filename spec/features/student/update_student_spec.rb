require 'rails_helper'

feature 'Update student', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with success' do
    sign_in user
    create_student
    data_update = update_student
    expect(page).to have_content('Estudante atualizado com sucesso')
    expect(page).to have_content(data_update.name)
  end
end
