Rails.application.routes.draw do
  devise_for :users
  get 'home/about' => 'homes#about', as: 'about'


  resources :users,only: [:show,:index,:edit,:update]


  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end




  root 'homes#top'

end