Rails.application.routes.draw do
  resources :offers
  resources :deals
  resources :profiles
  devise_for :users
  resources :posts
  get 'stylists' => 'profiles#stylists'
  get 'scrubs' => 'profiles#scrubs'
  get 'request/:id', to: 'deals#request_deal', as: 'request_deals'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#index"
end
