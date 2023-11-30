Rails.application.routes.draw do
  get 'clear_business' => 'common_actions#clear_business'
  get 'find_business' => 'common_actions#find_business'
  get 'documents' => 'common_actions#documents'
  get 'declarations' => 'common_actions#declarations'
  get '/new_vehicle/:id', to: 'vehicles#new', as: 'new_vehicle'
  post '/create_vehicle/:user_id', to: 'vehicles#create'
  get '/vehicle/:id', to: 'vehicles#show', as: 'vehicle'
  get '/edit_vehicle/:id', to: 'vehicles#edit', as: 'edit_vehicle'
  patch '/update_vehicle/:id', to: 'vehicles#update', as: 'update_vehicle'
  delete '/delete_vehicle/:id', to: 'vehicles#destroy', as: 'delete_vehicle'
  get '/new_estate/:id', to: 'estates#new', as: 'new_estate'
  post '/create_estate/:user_id', to: 'estates#create', as: 'create_estate'
  get '/estate/:id', to: 'estates#show', as: 'estate'
  get '/edit_estate/:id', to: 'estates#edit', as: 'edit_estate'
  patch '/update_estate/:id', to: 'estates#update', as: 'update_estate'
  delete '/delete_estate/:id', to: 'estates#destroy', as: 'delete_estate'
  get 'index' => 'inspector_actions#index'
  get '/list/:field' => 'inspector_actions#list', as: 'list'
  get '/show_user/:id', to: 'inspector_actions#show_user', as: 'show_user'
  get '/edit_user/:id', to: 'inspector_actions#edit_user', as: 'edit_user'
  patch '/update_user/:id', to: 'inspector_actions#update_user', as: 'update_user'
  root 'main_page#home'
  get 'sessions/new'
  get 'account' => 'personal_actions#account'
  get 'become_entrepreneur' => 'personal_actions#become_entrepreneur'
  get 'create_business' => 'personal_actions#create_business'
  patch 'confirm_status' => 'personal_actions#confirm_status'
  get 'property' => 'personal_actions#property'
  get '/signup/:field', to: 'users#new', as: 'signup'
  post '/create_user/:user_id', to: 'users#create', as: 'create_user'
  get 'show' => 'users#show'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  get '/edit/:id', to: 'users#edit', as: 'edit'
  patch '/update/:id', to: 'users#update', as: 'update'

  resources :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
