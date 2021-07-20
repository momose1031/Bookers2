Rails.application.routes.draw do

  devise_for :users
  root to: 'homes#top'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy] do
    get :favorites, on: :collection
    resource :favorite, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'

  resources :users, only: [:index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
    member do
      get :followings, :followers
    end
  end

end