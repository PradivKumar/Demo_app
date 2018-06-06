Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'users#index'
get '/index', to: 'users#index'
get '/signup', to: 'users#new'
get '/show', to: 'users#show'
resources :users
end
