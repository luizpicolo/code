require 'rails_helper'

feature 'Create school performace', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with correct data' do
    sign_in user
    create_school_performace

    expect(page).to have_content('Desempenho escolar cadastro com sucesso')
  end
end
