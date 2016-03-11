Rails.application.routes.draw do
  devise_for :users

  resources :resumes
  resources :objectives
  # root 'resumes#index'
  root 'root#index'
end
