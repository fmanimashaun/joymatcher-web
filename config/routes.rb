Rails.application.routes.draw do
  # User-specific routes
  resources :users, only: [] do
    resources :notifications, only: [ :index ]
    resource :profile, only: [ :show, :edit, :update ]
    resource :settings, only: [ :edit, :update ]
  end

  devise_for :users

  # Defines the root path route ("/")
  root to: "home#index"
end
