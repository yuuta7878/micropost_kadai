# ユーザ登録用のルーティング
Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
  # フォロー中のユーザとフォローされているユーザ一覧を表示するページは必要です。そのためのルーティング
    member do
      get :followings
      get :followers
      get :microposts
      get :favorites
    end
  end
  # create, destroy アクション実装
  resources :microposts, only: [:create, :destroy]
  # ログインユーザがユーザをフォロー/アンフォローできるようにするルーティング設定
  resources :relationships, only: [:create, :destroy]
  # ログインユーザーがお気に入り登録できるようにするルーティング設定　12/10
  resources :favorites, only: [:create, :destroy]
end