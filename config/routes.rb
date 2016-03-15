Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  resources :users, except: [:index, :destroy] do
    resources :websites, except: [:index, :show]
    resources :tags

    resources :assets, only: [:index, :new]
    resources :objectives, except: [:index]
    resources :educations, except: [:index]
    resources :experiences, except: [:index]
      resources :descriptions, except: [:index]
    resources :projects, except: [:index]
    resources :skills, except: [:index]
    resources :volunteerings, except: [:index]
    resources :taggings, except: [:index, :show]
    resources :resume_assets, except: [:index, :show]
    # resources :resume_print
    resources :resumes

  end



  get':controller(/:action(/:id))'

  root 'root#index'
end
