Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # root '/'
  get '/', to: 'root#index'
  
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  
  get '/dashboard', to: 'users#show'

  get '/discover', to: 'users#discover'
  get '/movies', to: 'movies#results'

  get '/movies/:movie_id', to: 'movies#details'
  
  get '/movies/:movie_id/viewing-party/new', to: 'viewing_party#new'
  post '/movies/:movie_id/viewing-party/new', to: 'viewing_party#create'

  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'

  delete '/logout', to: 'users#destroy'
  
end
