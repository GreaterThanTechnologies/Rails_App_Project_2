Rails.application.routes.draw do
  
  resources :owners  do 
    resources :items
  end
  
  resources :items do
    resources :inventories
  end

  resources :inventories
  resources :items
  resources :owners

  get '/signup' => "owners#new", as: "signup"
  post '/signup' => "owners#create"
  get '/login' => "sessions#new", as: "login"
  post '/login' => "sessions#create"
  post '/logout' => "sessions#destroy"
  get '/auth/facebook/callback' => 'sessions#create_with_fb'
  patch '/owners/:id/edit' => 'owners#update'
  # get '/most' => 'items#most'
  get '/search' => 'items#search', as: 'search_page'
  post '/search' => 'items#results'
  root :to => 'sessions#welcome'

 end
