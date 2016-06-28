Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
  	get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :movies do
    collection do
      get 'search'
    end
  	resources :reviews, only: [:new], controller: 'movies/reviews'
  end
  resources :reviews, except: [:new], controller: 'movies/reviews'
  root 'movies#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end