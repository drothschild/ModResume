Rails.application.routes.draw do
  devise_for :users

  resources :resumes
  resources :objectives

  get':controller(/:action(/:id))'

  root 'resumes#index'
end
