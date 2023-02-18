Rails.application.routes.draw do
  resources :chats
  resources :reviews
  resources :exchanges
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # route for google map nearby search
  get "/search", to: "google_maps#search"

  # Defines the root path route ("/")
  # root "articles#index"
end
