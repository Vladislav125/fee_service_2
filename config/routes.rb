Rails.application.routes.draw do
  resources :users
  resources :models
  root 'main_page#home'
  get 'account', to: 'personal_actions#account'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
end
