Rails.application.routes.draw do
  devise_for :users
  root 'books#top'
  get "home/about" => "books#about"
  resources :books, only:[:new, :create, :show, :index]
  resources :users, only:[:index, :show, :edit]
end
