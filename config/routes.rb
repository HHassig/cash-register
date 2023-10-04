Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items
  resources :promotions
  resources :transactions
  resources :baskets
end
