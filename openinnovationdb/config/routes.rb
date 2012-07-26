Openinnovationdb::Application.routes.draw do

  resources :gitusers

  resources :companies

  mount Resque::Server.new, :at => "/resque"
  get "groups/index"

  match "/groups/show/:id" => 'groups#show',:as=>:group
  root :to => "home#index"
  resources :users, :only => [ :show, :edit, :update ]
  match '/auth/:provider/callback' => 'sessions#create'
  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/auth/failure' => 'sessions#failure'
  match '/import' => 'meetups#importer'
  match '/import/again' =>'meetups#from_meetup'
  match '/import/dropdb'=>'meetups#dropdb'
  resources :members
  match '/import/topics' => 'topickeys#import'
  match '/import/topics/dropdb' => 'topickeys#dropdb'
  match '/import/groups'=>'meetups#import_groups'
  match '/import/groups/dropdb' => 'meetups#drop_groupdb'
  match '/import/gitusers' => 'meetups#import_gitusers'
  match '/import/companies' => 'meetups#import_companies'
  match '/topics' => 'topickeys#index'
  match '/topics/filtered' => 'topickeys#filtered'
  match '/topics/tags' => 'topickeys#tags'
  match '/topics/statistics' => 'topickeys#statistics'
end
