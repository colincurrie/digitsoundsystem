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
  resources :events, concerns: :commentable
  resources :photos, concerns: [:commentable, :scorable]
  resources :mixtapes, concerns: [:commentable, :scorable]
  resources :tunes, concerns: [:commentable, :scorable]
  resources :videos, concerns: [:commentable, :scorable]

  # A specific route to delete the image for a story
  delete '/stories/:id/image' => 'stories#remove_image', as: :remove_image

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
