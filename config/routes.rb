Rails.application.routes.draw do
  get "upgrades/index"

  # User-specific routes
  resources :users, only: [] do
    resources :notifications, only: [ :index ]
    resource :profile, only: [ :show, :edit, :update ]
    resource :settings, only: [ :edit, :update ]
  end

  # Upgrade route
  resources :upgrades, only: [ :index ] do
    collection do
      get "success"
    end
  end

  # Dashboard route
  resource :dashboard, only: [ :show ]

  devise_for :users

  # Dashboard as the root for authenticated users
  authenticated :user do
    root to: "dashboard#show", as: :authenticated_root
  end

  # Root for non-authenticated users
  root to: "home#index"
end
