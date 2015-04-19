Rails.application.routes.draw do
  get '/responders/:name', to: 'responders#show'
  patch '/responders/:name', to: 'responders#update'

  get '/emergencies/:name', to: 'emergencies#show'
  patch '/emergencies/:name', to: 'emergencies#update'

  resources :emergencies, except: [:show, :update]
  resources :responders, except: [:show, :update]
end
