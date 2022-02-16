Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root '/'
  get '/', to: 'root#index'
  
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  resources :users, only: [:show]

  get '/users/:id/discover', to: 'users#discover'
  get '/users/:id/movies', to: 'movies#results'

  get '/users/:id/movies/:movie_id', to: 'movies#details'
  
  get '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_party#new'
  post '/users/:id/movies/:movie_id/viewing-party/new', to: 'viewing_party#create'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  
end
