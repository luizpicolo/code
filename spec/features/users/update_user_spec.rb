require 'rails_helper'

feature 'Update user', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with success' do
    sign_in user
    data_update = update_user
    expect(page).to have_content('Usuário atualizado com sucesso')
    expect(page).to have_content(data_update.name)
  end
end
