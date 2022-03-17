Rails.application.routes.draw do
  root "home#top"
  get '/users/new', to: 'users#new'
  get '/users/:uid', to: 'users#show', as: 'users_show'
  post '/users', to: 'users#create'
  post 'users/:user_id/relationships', to: 'relationships#create', as: 'relationships_create'
  delete 'users/:user_id/relationships', to: 'relationships#destroy', as: 'relationships_destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/posts', to: 'posts#index'
  get '/posts/:pid', to: 'posts#show', as: 'posts_show'
  post '/posts', to: 'posts#create', as: 'posts_create'
  delete '/posts/:id', to: 'posts#destroy', as: 'posts_destroy'
  post '/posts/:pid/comments', to: 'comments#create', as: 'comments_create'
  delete '/comments/:id', to: 'comments#destroy', as: 'comments_destroy'

end
