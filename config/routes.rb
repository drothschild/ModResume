Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }

  resources :users, except: [:index, :destroy] do
    resources :websites, except: [:index]
    resources :tags

    resources :assets, only: [:index, :new]
    resources :objectives, except: [:index]
    resources :educations, except: [:index]
    resources :experiences, except: [:index]
      resources :descriptions, except: [:index]
    resources :projects, except: [:index]
    resources :skills, except: [:index]
    resources :volunteerings, except: [:index]
    resources :taggings, except: [:index]
    resources :resume_assets, except: [:index]
    resources :resume_print
    resources :resumes

  end


  get':controller(/:action(/:id))'

  post 'users/:id/resumes/:id/fine-tune', to: 'resumes#fine_tune', as: 'user_resume_fine_tune'

  root 'root#index'
end
