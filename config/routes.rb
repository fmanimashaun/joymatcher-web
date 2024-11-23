Rails.application.routes.draw do
  get "notifications/index"
  get "profiles/show"
  get "profiles/edit"
  get "profiles/update"
  get "messages/index"
  get "messages/show"
  get "messages/create"
  get "settings/edit"
  get "settings/update"
  devise_for :users

  # Defines the root path route ("/")
  root to: "home#index"
end
