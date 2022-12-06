Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to:"homes#top"
  get "home/about"=>"homes#about", as:"about"

  resources :users, only:[:index, :show, :edit, :update] do
    resource :relationships, only:[:create, :destroy]
    member do
      get "favorites"=>"users#favorites"
    end
    get "followings"=>"relationships#followings", as:"followings"
    get "followers"=>"relationships#followers", as:"followers"
  end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end


  resources :trainings do
    resource :favorites, only:[:create,:destroy]
    resources :comments, only:[:create,:destroy]
  end

  resources :messages,only:[:show,:create,:destroy]

  resources :groups do
    get "join"=>"groups#join"
    delete "leave"=>"groups#leave"
    resources :group_chats,only:[:index,:create,:destroy]
  end

end
