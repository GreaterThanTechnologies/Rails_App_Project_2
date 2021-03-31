Rails.application.routes.draw do
  # resources :inventories
  # resources :items
  # resources :owners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, except: [:show, :idex, :new, :create, :destroy, :patch, :put] do 
    resources :items, except: [:show, :edit, :update, :destroy, :put]
  end
  
  resources :items, except:[:put] do
    resources :inventories, only: [:new, :create]
  end

  # UNSURE  if these will work prooperly, remove this line when confirmed properly working
  resources :inventories, only: [:new, :create, :index]
  get '/signup', to: "users#new", as: "signup"
  post '/signup', to: "users#create"
  get '/login', to: "sessions#new", as: "login"
  post '/login', to: "sessions#create"
  post '/logout', to: "sessions#destroy"
  get "/auth/facebook/callback", to: "sessions#create_with_fb"
  root 'owners#home'
end
