Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'

  resources :beers

  post '/favorite', to: 'beers#save_favorite'
  get '/favorite', to: 'beers#get_favorites'
end
