Rails.application.routes.draw do

  devise_for :users

  resources :users
  resources :incidents
  resources :school_performaces do
    get :autocomplete_student_name, on: :collection
  end
  resources :students
  get '/report' => 'report#index', as: :report
  get '/report/print' => 'report#print', as: :report_print

  mount_rails_db_info as: 'rails_db_info_engine' if Rails.env.development?

  root 'home#index'
end
