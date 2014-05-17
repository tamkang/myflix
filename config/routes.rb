Myflix::Application.routes.draw do
  root to: 'pages#root'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/', to: 'pages#root'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/logout', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'
  post '/update_queue', to: 'queue_items#update_queue'
  get '/people', to: 'relationships#index'
  resources :forgot_passwords, only:[:new, :create]
  get '/forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :reset_passwords, only:[:show, :create]
  get '/expired_token', to: 'reset_passwords#invalid'

  resources :invitations, only:[:new, :create]

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'  
    end

    resources :reviews, only: [:create]
  end

  resources :users, only: [:show, :create, :edit, :update]
  get '/new_with_invitation_token', to: 'users#new_with_invitation_token'


  resources :categories
  resources :relationships, only: [:create, :destroy]
  resources :queue_items, only: [:create, :destroy]
end
