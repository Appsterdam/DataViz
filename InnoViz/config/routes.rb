InnoViz::Application.routes.draw do

  resources :positions

  resources :gitusers

  resources :companies

  match 'topickeys/tags' => 'topickeys#tags'
  match 'topickeys/filtered' => 'topickeys#filtered'
  resources :topickeys

  resources :groups

  mount Resque::Server.new, :at => "/resque"

  get "importcentral/index",:as => "importer"

  resources :members

  root :to => "home#index"
  resources :users, :only => [ :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
end
