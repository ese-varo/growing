Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'profile', to: 'users/registrations#show'
  end
  resources :habits, only: %i[index create show edit update]
  resources :days do
    resources :note, only: %i[create update]
    resources :checkpoint
  end
  resources :note, only: %i[destroy]
end
