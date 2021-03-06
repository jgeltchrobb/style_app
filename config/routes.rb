Rails.application.routes.draw do
  resources :comments
  resources :offers
  resources :deals
  resources :profiles do
    resources :locations
  end
  devise_for :users
  resources :posts
  resources :charges
  resources :conversations do
    resources :messages
  end
  resources :reviews
  # resources :locations
  get 'stylists' => 'profiles#stylists'
  get 'scrubs' => 'profiles#scrubs'
  get 'request/:id', to: 'deals#request_deal', as: 'request_deals'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#index"
end
