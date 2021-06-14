Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'users/show'
  devise_for :users
  root to:'homes#top'
  
  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create,:destroy]
    get :follows, on: :member #ユーザーidを含むURL
    get :followers, on: :member #ユーザーidを含むURL
  end 
  
  resources :blogs do
    resources :post_comments,only: [:create,:destroy]
    resource :favorites,only: [:create,:destroy]
  end  
end
