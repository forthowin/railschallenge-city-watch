Rails.application.routes.draw do
  get '/responders/:name', to: 'responders#show'
  patch '/responders/:name', to: 'responders#update'

  get '/emergencies/:name', to: 'emergencies#show'

  resources :emergencies
  resources :responders, except: [:show, :update]
end
