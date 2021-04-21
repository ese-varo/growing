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
  get 'checkpoint_toggle/:id', to: 'checkpoint#toggle_status', as: 'checkpoint_toggle'
  resources :note, only: %i[destroy]
  get 'habit_toggle/:id', to: 'habits#toggle_status', as: 'habit_toggle'
end
