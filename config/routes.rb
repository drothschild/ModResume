Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  resources :users do
    resources :websites
    resources :tags

    resources :assets
    resources :objectives
    resources :educations
    resources :experiences
    resources :projects
    resources :skills
    resources :volunteerings
    resources :taggings
    resources :resume_assets

    resources :resumes

  end



  get':controller(/:action(/:id))'

  root 'root#index'
end
