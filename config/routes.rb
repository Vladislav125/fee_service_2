Rails.application.routes.draw do
  get '/new_vehicle/:id', to: 'vehicles#new', as: 'new_vehicle'
  post '/create_vehicle/:user_id', to: 'vehicles#create', as: 'create_vehicle'
  get '/vehicle/:id', to: 'vehicles#show', as: 'vehicle'
  delete '/delete_vehicle/:id', to: 'vehicles#destroy', as: 'delete_vehicle'
  get '/new_estate/:id', to: 'estates#new', as: 'new_estate'
  post '/create_estate/:user_id', to: 'estates#create', as: 'create_estate'
  get '/estate/:id', to: 'estates#show', as: 'estate'
  delete '/delete_estate/:id', to: 'estates#destroy', as: 'delete_estate'
  get 'index' => 'inspector_actions#index'
  get '/show_user/:id', to: 'inspector_actions#show_user', as: 'show_user'
  root 'main_page#home'
  get 'sessions/new'
  get 'account' => 'personal_actions#account'
  get 'signup' => 'users#new'
  get 'show' => 'users#show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  patch 'update' => 'users#update'

  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
