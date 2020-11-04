Rails.application.routes.draw do
  devise_for :users
  root 'books#top'
  get "home/about" => "books#about"
  resources :books, only:[:new, :create, :show, :index, :edit, :update, :destroy] do
    resources :book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  resources :users, only:[:index, :show, :edit, :update]
end
