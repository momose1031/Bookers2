Rails.application.routes.draw do
  
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:index, :show, :edit, :update]
  get 'home/about' => 'homes#about'
  
end
