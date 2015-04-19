Rails.application.routes.draw do
  resources :emergencies, except: [:show, :update]
  resources :responders, except: [:show, :update]

  get '/responders/:name', to: 'responders#show'
  patch '/responders/:name', to: 'responders#update'

  get '/emergencies/:code', to: 'emergencies#show'
  patch '/emergencies/:code', to: 'emergencies#update'
end
