Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  get 'sessions/new'
  root 'static_pages#home'
  get 'static_pages/home'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers, :likes
    end
  end
  resources :microposts, only: %i[create destroy edit update index] do
    resources :comments, only: %i[create index ]
  end
  resources :relationships, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
