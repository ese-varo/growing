Rails.application.routes.draw do
  root 'home#index'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get 'profile', to: 'users/registrations#show'
  end
  resources :habits, only: %i[index create show]
  resources :days do
    resources :note
  end
end
