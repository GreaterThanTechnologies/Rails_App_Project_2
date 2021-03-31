Rails.application.routes.draw do
  # resources :inventories
  # resources :items
  # resources :owners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :owners, except: [:show, :idex, :new, :create, :destroy, :patch, :put] do 
    resources :items, except: [:show, :edit, :update, :destroy, :put]
  end
  
  resources :items, except:[:put] do
    resources :inventories, only: [:new, :create]
  end

  # UNSURE  if these will work prooperly, remove this line when confirmed properly working
  resources :inventories, only: [:new, :create, :index]

  get '/signup' => "owners#new", as: "signup"
  post '/signup' => "owners#create"
  get '/login' => "sessions#new", as: "login"
  post '/login' => "sessions#create"
  post '/logout' => "sessions#destroy"
  get "/auth/facebook/callback" => "sessions#create_with_fb"
  get '/' => 'sessions#welcome' 
end
