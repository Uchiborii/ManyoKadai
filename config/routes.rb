Rails.application.routes.draw do
  get 'sessions/new'
  root to: 'tasks#index'
  resources :users, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  resources :sessions, only: [:new, :create, :destroy]
  resources :tasks do
    collection do
      post :confirm
    end
  end
end
