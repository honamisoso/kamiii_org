Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top" #
  resources :users, only: [:edit, :index, :show, :update, :create, :destroy,]
  resources :books, only: [:edit, :index, :show, :update, :create, :destroy,]
  get "home/about" => "homes#about", as: "about"
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'
  get '/search', to: 'searches#search'
  resources :comments, only: %i(create destroy)
end
