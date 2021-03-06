Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'users#index'
get '/index', to: 'users#index'
get '/signup', to: 'users#new'
get '/front', to: 'users#front'
get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'
get "posts/:id/undoup", to: redirect("/")
get "posts/:id/up", to: redirect("/")
get "posts/:id/down", to: redirect("/")
get "posts/:id/undodown", to: redirect("/")
resources :users
resources :posts

resources :users do
	member do
		get :following, :followers, :blocked
		get :liked, :disliked
	end
end

resources :posts do
	member do	
		post :up, :down
		delete :undoup, :undodown
	end
end


get "/notification", to: 'users#notification'
resources :relationships, only: [:create, :destroy, :update]
resources :likes, only: [:create, :destroy]
resources :comments, only: [:create, :destroy]
end
