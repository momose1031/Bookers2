Rails.application.routes.draw do
  
  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    resource :favorite, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about'
  
  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :followings, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
  
  
