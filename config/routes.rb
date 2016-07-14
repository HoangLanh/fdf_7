Rails.application.routes.draw do
  devise_for :users
  root "products#index"
  get "/cart" =>"cart#index"
  delete "/cart/:id/delete" => "cart#destroy"
  get "/cart/:id" =>"cart#create"
  get "/cart/:id/edit" => "cart#edit"
  get "help" => "static_pages#help"
  get "about" => "static_pages#about"
  get "contact" => "static_pages#contact"
  post "/cart/:id" => "cart#update"
  resources :users, only: [:show, :edit, :update]

  resources :products, only: [:index, :show] do
    resources :comments, except: [:index, :show]
  end
  resources :cart

  namespace :admin do
    resources :categories, except: :show
    resources :users, only: [:index, :destroy]
    resources :products, except: :show
  end
end
