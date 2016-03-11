Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  resources :resumes
  resources :objectives
  # root 'resumes#index'
  root 'root#index'
end
