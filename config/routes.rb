Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "user/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:new, :create, :index]
  resources :users, only: [:show]
  resources :gift_codes, only: [:index]

  root to: 'welcome#index'

end
