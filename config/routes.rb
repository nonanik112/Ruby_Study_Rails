Rails.application.routes.draw do
  resources :sessions
  get '/authenticate', to: 'sessions#authenticate'
  get '/me', to: 'sessions#me'
end
