Rails.application.routes.draw do
  resources :profiles
  devise_for :users
  resources :posts
  get 'stylists' => 'profiles#stylists'
  get 'scrubs' => 'profiles#scrubs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#index"
end
