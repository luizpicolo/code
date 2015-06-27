require 'rails_helper'

feature 'delete student', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with success' do
    sign_in user

    delete_school_performace(create_school_performace)

    expect(page).to have_content('Desempenho escolar excluído com sucesso')
  end
end
