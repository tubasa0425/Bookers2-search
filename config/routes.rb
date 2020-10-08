Rails.application.routes.draw do
  devise_for :users
  get 'home/about' => 'homes#about', as: 'about'
  
  
  root 'homes#top'
  
  # フォローフォロワー機能の実装ここから
  
  
    # フォローする
  post 'follow/:id' => 'relationships#follow', as: 'follow' 
  
    # フォロー外す
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' 
  
  
  
  # フォローフォロワー機能の実装ここまで
  
  


  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end

# resources :users,only: [:show,:index,:edit,:update]

  resources :users do
    member do
     get :following, :followers
    end
  end
  

end