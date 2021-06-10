Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  root to:'homes#top'
  resources :users,only: [:show,:index]
  resources :blogs do
    resources :post_comments,only: [:create,:destroy]
  end  
end
