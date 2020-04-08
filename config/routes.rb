Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"
  get "/signup", to: "users#new"
  get "/search", to: "cars#index"
  get "/orders", to: "orders#index"
  resources :orders do
    patch "/deny", to: "orders#deny"
    patch "/approved", to: "orders#approved"
    patch "/cancel", to: "orders#cancelled"
    resources :extension_orders
  end
  resources :extension_orders do
    patch "/deny", to: "extension_orders#deny"
    patch "/approved", to: "extension_orders#approved"
    patch "/cancel", to: "extension_orders#cancelled"
  end
  resources :users
  resources :account_activations
  resources :cars do
    resources :orders
  end
  resources :password_resets
end
