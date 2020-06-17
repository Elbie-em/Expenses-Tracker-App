Rails.application.routes.draw do
  resources :expenses
  resources :groups
  resources :home, only: [:index]
  devise_for :users, :controllers => { registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'home/main'
  get 'home/external'
  get 'home/friends'

  root "home#index"
end
