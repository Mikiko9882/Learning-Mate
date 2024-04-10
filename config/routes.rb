Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'tops#index'

  resource :user_session, only: [:new, :create, :destroy]
  resources :users, only: %i[new create]

  resources :test_results, except: [:show] do
    collection do
      get :subject_achievement_rate
    end
  end

  namespace :teacher do
    root to: 'users#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
    resources :users, only: %i[index edit update show destroy]
    
    resources :test_results, only: %i[index edit update show destroy] do
      collection do
        get :subject_achievement_rate
      end
    end
  end
end
