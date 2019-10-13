Rails.application.routes.draw do
  root 'items#index'

  get 'base_clients/new', to: 'base_clients#new'
  get 'base_clients/complete', to: 'base_clients#complete'
  post 'base_clients', to: 'base_clients#create'
  get '/base_callback', to: 'base_callback#callback'

  resources :items

  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/login', to: redirect('/sign_in')
  delete '/logout', to: 'sessions#destroy'
  get '/sign_up', to: 'registrations#new'
  post '/sign_up', to: 'registrations#send_confirm'
  get '/sign_up/confirm', to: 'registrations#confirm'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

end
