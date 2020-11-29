Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy' #3件いずれも、URLの見栄え重視でresourcesを使わない。　resources :sessions, only: [:new, :create, :destroy]
  
  get 'signup', to: 'users#new' #下記でusers#newを設定しているにもかかわらずここで設定するのは、URLを/signupにするため。URLが/users/newだと少々不恰好。
  resources :users, only: [:index, :show, :new, :create] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end
  
  resources :microposts, only: [:create, :destroy]  #do #microposts単独でのshowは必要ない。userに紐づいており、(一覧)表示するにしてもそちらでするため。
=begin
    member do
      get :attracteds
    end
  end
=end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :favorites, only: [:create, :destroy]

end
