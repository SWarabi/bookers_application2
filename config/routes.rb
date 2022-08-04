Rails.application.routes.draw do
  get 'chats/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  get "search" => "searches#search"
  get "home/about"=>"homes#about"#, as: 'about'
  root to: 'homes#top'
  
  #get 'chat/:id', to: 'chats#show', as: 'chat'
  #resources :chats, only: [:create]
  resources :chats, only: [:show, :create]

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do 
    resources :relationships, only: [:create, :destroy, :followers]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
