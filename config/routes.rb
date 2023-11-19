Rails.application.routes.draw do
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
