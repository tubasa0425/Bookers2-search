Rails.application.routes.draw do
  devise_for :users
  
  # aboutサイトのルーティング
  get 'home/about' => 'homes#about', as: 'about'
  
  
  # 検索機能のルーティング
  get 'search' => 'search#search'
  
  
  # ”/”でトップサイトを表示するルーティング
  root 'homes#top'
  
  
  # フォローフォロワー機能の実装ここから
    # フォローする
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  
    # フォロー外す
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 
  # フォローフォロワー機能の実装ここまで
  


  resources :books do
    # get :search, on: :collection
    
    
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end


  resources :users do
    # get :search, on: :collection

    
    member do
     get :following, :followers
    end
  end
  
# resources :users,only: [:show,:index,:edit,:update]

end