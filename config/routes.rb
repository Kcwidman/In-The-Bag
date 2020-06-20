Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations"
  }
  resources :discs
  resources :bags do
    resource :slots, only: [:edit, :update]
  end
  resources :users
  resources :offers do
    collection do
      get :my_offers
      get :select
    end
  end
  resources :conversations do
    resources :messages, only: [:create]
  end
  resource :follows, only: [:create, :destroy]
  resource :landing_page, only: [:index]

  root "landing_page#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
