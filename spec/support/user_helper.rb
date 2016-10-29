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

module UserHelpers
  def sign_in(user, options = {})
    password = options[:password] || user.password

    visit root_path

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: password
    click_button 'Entrar'
  end

  def sign_out
    click_link 'Sair do sistema'
  end

  # Create new user
  def create_user(options = {})
    email = options[:email] || Faker::Internet.email
    pwd = options[:password] || Faker::Internet.password

    click_link('Usuários')
    click_link('Novo usuário')

    fill_in 'Nome', with: Faker::Name.name
    fill_in 'Email', with: email
    fill_in 'Senha', with: pwd
    fill_in 'Confirmar senha', with: pwd
    check('Admin') if options[:admin]
    check('Ativo') if options[:status]

    click_button('Criar Usuário')

    search_user_by_email(email)
  end

  # Create new user
  def update_user(options = {})
    email = options[:email] || Faker::Internet.email
    click_link('Usuários')
    first(:link, 'Editar').click

    fill_in 'Nome', with: Faker::Name.name
    fill_in 'Email', with: email
    check('Admin') if options[:admin]
    check('Ativo') if options[:status]

    click_button('Atualizar Usuário')

    search_user_by_email(email)
  end

  # delete
  def delete_user(user)
    page.driver.submit :delete, "/users/#{search_user_by_email(user.email).id.to_s}", {}
  end

  def search_user_by_email(email)
    User.find_by_email(email)
  end
end

RSpec.configure do |config|
  config.include UserHelpers, type: :feature
end
