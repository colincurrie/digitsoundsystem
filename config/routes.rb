Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, controllers: { registrations: 'users' }

  concern :commentable do
    resources :comments
  end

  concern :scorable do
    member do
      get 'move_up'
      get 'move_down'
    end
  end

  resources :stories, concerns: :commentable
  resources :photos, concerns: :commentable
  resources :mixtapes, concerns: :commentable
  resources :tunes, concerns: [:commentable, :scorable]
  resources :videos, concerns: [:commentable, :scorable]
  resources :events

  # A single non-persistent contact for the form
  resource :contact, only: [:show, :create], controller: 'contact'

  # alternative routes for resources
  get '/news', controller: :stories, action: :index
  get '/gallery', controller: :photos, action: :index

  # custom routes
  get '/djs', to: 'djs#show'
  get '/calendar', to: 'events#index'
  get '/contact', to: 'contact#show'

end
