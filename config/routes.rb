Rails.application.routes.draw do
  resources :discs
  resources :bags
  root "discs#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
