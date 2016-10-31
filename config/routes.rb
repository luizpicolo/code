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

Rails.application.routes.draw do
  devise_for :users

  resources :users
  get '/perfil' => 'users#profile'

  resources :incidents
  resources :school_performaces do
    get :autocomplete_student_name, on: :collection
  end
  resources :students
  get '/report' => 'report#index', as: :report
  get '/report/print' => 'report#print', as: :report_print
  get '/about' => 'about#index', as: :about

  mount_rails_db_info as: 'rails_db_info_engine' if Rails.env.development?

  root 'home#index'
end
