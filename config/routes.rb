Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  root 'static_pages#home'
  get  '/signup',  to: 'users#new'
  resources :users
  resources :account_activations
  resources :cars
  resources :password_resets
end