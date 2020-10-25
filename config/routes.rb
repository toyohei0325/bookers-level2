Rails.application.routes.draw do
  devise_for :users
  root 'books#top'
  get "home/about" => "books#about"
  resources :books, only:[:new, :create, :show, :index, :edit, :update, :destroy]
  resources :users, only:[:index, :show, :edit, :update]
end
