Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'users#index'
get '/index', to: 'users#index'
get '/signup', to: 'users#new'
get '/front', to: 'users#front'
get '/login', to: 'sessions#new'

post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'
resources :users
resources :posts, only: [:create, :destroy]
resources :users do
	member do
		get :following, :followers
	end
end
resources :relationships, only: [:create, :destroy]
resources :likes, only: [:create, :destroy]
end
