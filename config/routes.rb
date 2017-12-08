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
    end
  end
  # create, destroy アクション実装
  resources :microposts, only: [:create, :destroy]
  # ログインユーザがユーザをフォロー/アンフォローできるようにするルーティング設定
  resources :relationships, only: [:create, :destroy]
end