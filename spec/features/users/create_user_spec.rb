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
