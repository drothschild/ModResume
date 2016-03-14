Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  resources :users do
    resources :websites
    resources :tags

    resources :assets
    resources :objectives
    resources :educations
    resources :experiences
      resources :descriptions
    resources :projects
    resources :skills
    resources :volunteerings
    resources :taggings
    resources :resume_assets
    resources :resume_print
    resources :resumes

  end



  get':controller(/:action(/:id))'

  root 'root#index'
end
