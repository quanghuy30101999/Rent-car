Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/search", to: "cars#index"
  resources :users
  resources :account_activations
  resources :cars do
    resources :orders
  end
  resources :password_resets
end
