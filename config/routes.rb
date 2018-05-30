Rails.application.routes.draw do
  resources :customers, only: [:index]
  root to: 'customers#index'
end
