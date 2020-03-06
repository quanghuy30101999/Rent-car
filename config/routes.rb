Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/signup',  to: 'users#new'
  get  '/search' => 'static_pages#index', :as => 'search_page'  
  resources :users
  resources :account_activations
  resources :cars
  resources :password_resets
end