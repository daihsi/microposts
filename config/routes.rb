Rails.application.routes.draw do
  root "home#top"
  get '/users/new', to: 'users#new'
  get '/users/:uid', to: 'users#show', as: 'users_show'
  post '/users', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/posts', to: 'posts#index'
  get '/posts/:pid', to: 'posts#show', as: 'posts_show'
  post '/posts', to: 'posts#create', as: 'posts_create'
  delete '/posts/:id', to: 'posts#destroy', as: 'posts_destroy'
end
