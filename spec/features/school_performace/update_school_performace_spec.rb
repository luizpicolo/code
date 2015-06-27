require 'rails_helper'

feature 'Update student', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with success' do
    sign_in user
    create_school_performace
    data_update = update_school_performace
    expect(page).to have_content('Desempenho escolar atualizado com sucesso')
    expect(page).to have_content(data_update.student.name)
  end
end
