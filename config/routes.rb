Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items, only: [:new, :create] do
    resources :purchase_histories, only: [:index, :create]
  end
end
