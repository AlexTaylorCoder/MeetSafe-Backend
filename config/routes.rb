Rails.application.routes.draw do
  
  resources :chats
  resources :reviews
  resources :exchanges
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # route for google map nearby search
  get "/search", to: "google_maps#search"

  # route to get other party coor
  get "/users/find/:username", to: "users#find_party"

  # Defines the root path route ("/")
  # root "articles#index"

  # User.rb routes
  get '/users', to: 'users#index'
  get '/me', to: 'users#show'       # staying logged in 
  # get '/auth', to: 'users#show'
  post '/signup', to: 'users#create'     # params : username, password, email
  patch '/users', to: 'users#update'    
  

  # # Login and Logout Routes - Sessions.rb
  get '/auth', to: 'sessions#index'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #Check user location to see if near meet spot

  post '/exchanges/location', to: 'exchanges#check_location'

  #Check if user can flag

  post '/exchanges/flag', to: 'exchanges#flag'
  
  #get users exchange history

  get 'history', to: 'exchanges#index' 

  # to create new invite with all meeting data
  post '/exchanges/new_meeting/:username', to: "exchanges#new_meeting"

  #User join check 
  get '/join/:id', to: 'exchanges#join'
end
