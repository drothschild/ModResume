Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  resources :users do
    resources :assets
  end

  resources :tags

  resources :resumes
  resources :objectives

  get':controller(/:action(/:id))'

  root 'root#index'
end
