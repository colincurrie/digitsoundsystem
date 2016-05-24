Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users, controllers: { registrations: 'users' }

  resources :stories do
    resources :comments
  end
  resources :photos do
    resources :comments
  end
  resources :mixtapes do
    resources :comments
  end
  resources :tunes do
    resources :comments
    member do
      get 'move_up'
      get 'move_down'
    end
  end
  resources :videos do
    member do
      get 'move_up'
      get 'move_down'
    end
  end
  resources :events

  # A single non-persistent contact for the form
  resource :contact, only: [:show, :create], controller: 'contact'

  get '/calendar', to: 'events#index'
  get '/contact', to: 'contact#show'
  get '/djs', to: 'djs#show'

  # alternative routes for resources
  get '/news', controller: :stories, action: :index
  get '/gallery', controller: :photos, action: :index

end
