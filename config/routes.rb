Rails.application.routes.draw do
  resources :inventories
  resources :items
  resources :owners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
