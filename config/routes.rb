Rails.application.routes.draw do
  root 'items#index'
  resources :items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/login', to: redirect('/sign_in')
  delete '/logout', to: 'sessions#destroy'

end
