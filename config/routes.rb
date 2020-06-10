Rails.application.routes.draw do
  resources :groups
  resources :home, only: [:index]
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/main'

  root "home#index"
end
