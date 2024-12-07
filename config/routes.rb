Rails.application.routes.draw do
  # Likes and Matches routes for authenticated users
  resources :likes, only: [ :index ]
  resources :matches, only: [ :index ]

  # notifications, profile and settings routes for authenticated users
  resources :notifications, only: [ :index ]
  resource :profile, only: [ :show, :edit, :update ]
  resource :settings, only: [ :edit, :update ]

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
