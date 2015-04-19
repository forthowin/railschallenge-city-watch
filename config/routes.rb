Rails.application.routes.draw do
  get '/responders/:name', to: 'responders#show'
  patch '/responders/:name', to: 'responders#update'

  resources :emergencies
  resources :responders, except: [:show, :update]
end
