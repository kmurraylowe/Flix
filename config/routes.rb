Rails.application.routes.draw do
  
  
  resources :genres
  resources :favorites
  root "movies#index"
 
  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resources :users
  resource :session, only: [:new, :create, :destroy]

get "signup" => "users#new"
get "signin" => "sessions#new"


get "movies/filter/:filter" => "movies#index", as: :filtered_movies
end
