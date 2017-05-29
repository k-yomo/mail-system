Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout', sign_up: 'register'}, controllers: { registrations: "user/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers
  resources :users, only: [:index]
  resources :gift_codes, only: [:index] do
    collection do
      post :import
      get :send_gift_all
    end
    member do
      get :code_status
      get :send_gift
    end
  end

  root to: 'welcome#index'
end
