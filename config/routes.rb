Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'users/show'
  put "/users/:id/hide" => "users#hide", as: 'users_hide'
  get "home/about" =>"homes#about"
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
    collection do
      get 'search'
    end
  end

end
