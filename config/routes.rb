Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resources :ratings, only: [:index, :new, :create, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :places, only: [:index, :show]

  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  get 'places', to: 'places#index'
  post 'places', to:'places#search'
  delete 'signout', to: 'sessions#destroy'
  get 'beerlist', to:'beers#list'
  get 'brewerylist', to:'breweries#list'

  root 'breweries#index'

end