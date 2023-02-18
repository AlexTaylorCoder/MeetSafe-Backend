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

  # User.rb routes
  get '/users', to: 'users#index'
  get '/me', to: 'users#show'       # staying logged in 
  # get '/auth', to: 'users#show'
  post '/signup', to: 'users#create'     # params : name, password, email, funds
  patch '/users', to: 'users#update'    # params : funds

  # # Login and Logout Routes - Sessions.rb
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
