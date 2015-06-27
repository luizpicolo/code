require 'rails_helper'

feature 'Create user', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'with correct data' do
    sign_in user
    create_user

    expect(page).to have_content('Usuário cadastro com sucesso')
  end

  scenario 'with incorrect email' do
    sign_in user
    create_user email: 'wrong_email'
    expect(page).to have_content('Email não é válido')
  end

  scenario 'with password below of 8 characters' do
    sign_in user
    create_user password: '123'
    expect(page).to have_content('Senha é muito curto (mínimo: 8 caracteres)')
  end
end
