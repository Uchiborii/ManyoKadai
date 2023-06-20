Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :users, only: [:index, :new, :create, :edit, :update, :destroy, :show]
  resources :sessions, only: [:new, :create, :destroy]
  namespace :admin do
    resources :users, only: [:index, :new, :create, :show]
  end
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
