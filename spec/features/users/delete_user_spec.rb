require 'rails_helper'

feature 'delete user', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with success' do
    sign_in user

    delete_user(create_user)

    expect(page).to have_content('Usuário excluído com sucesso')
  end
end
