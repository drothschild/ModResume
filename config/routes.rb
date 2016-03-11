Rails.application.routes.draw do
  devise_for :users

  resources :resumes
  root 'resumes#index'
end
