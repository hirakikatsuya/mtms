# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  get "/about" => "homes#about", as: "about"
  get "/search" => "searches#search"

  resources :users, only: [:index, :show, :edit, :update, :destroy] do
    resource :relationships, only: [:create, :destroy]
    member do
      resource :messages, only: [:show, :create, :destroy] do
        namespace :api do
          resources :messages, only: :show, defaults: { format: 'json' }
        end
      end
      get "favorites" => "users#favorites"
      patch "suspend" => "users#suspend"
      patch "unsuspend" => "users#unsuspend"
    end
    collection do
      get "suspend_users" => "users#suspend_users"
    end
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :trainings do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  resources :groups do
    member do
      get "join" => "groups#join"
      delete "leave" => "groups#leave"
      resources :group_chats, only: [:index, :create, :destroy]
    end
  end
end
