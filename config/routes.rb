Rails.application.routes.draw do
  get 'emergencies/new', to: 'application#page_not_found'
  get 'responders/new', to: 'application#page_not_found'

  resources :emergencies, except: [:new, :edit, :destroy], defaults: { format: :json }
  resources :responders, except: [:new, :edit, :destroy], defaults: { format: :json }

  match '/*path', to: 'application#page_not_found', via: :all
end
