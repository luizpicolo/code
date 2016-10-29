################################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 C.O.D.E
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
################################################################################

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
