require 'rails_helper'

feature 'Sign in', js: false do
  let!(:user) { FactoryGirl.create(:user, admin: true) }

  scenario 'with valid credentials' do
    sign_in user
    expect(page).to have_content('Login efetuado com sucesso!')
  end

  scenario 'with admin' do
    user.admin = true
    user.save
    sign_in user

    expect(page).to have_content('Estudante')
    expect(page).to have_content('Relatório')
    expect(page).to have_content('Usuários')
  end

  scenario 'with user' do
    user.admin = false
    user.save
    sign_in user

    expect(page).not_to have_content('Estudante')
    expect(page).not_to have_content('Relatório')
    expect(page).not_to have_content('Usuários')
  end

  scenario 'with invalid credentials' do
    sign_in user, password: 'wrongpassword'
    expect(page).to have_content('E-mail ou senha inválidos.')
  end
end
