Rails.application.routes.draw do
  devise_for :users
  root 'main_page#home'
  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    delete 'sign_out', to: 'devise/sessions#destroy'
    get 'sign_up', to: 'devise/registrations#new'

  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
