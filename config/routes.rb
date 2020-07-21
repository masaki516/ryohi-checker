Rails.application.routes.draw do

  get 'toppages', to: 'toppages#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  post 'guest', to: 'guest_sessions#create'

  resources :users, only: [:create]
  get 'signup', to: 'users#new'
  
  resources :travels, only: [:index, :new, :create, :destroy]
  root to: 'toppages#index'
  
  resources :budget_items, only: [:destroy, :update, :edit]
  get 'travels/:id/budget_items', to: 'budget_items#index',as: 'budget_items'
  get 'travels/:id/budget_items/new', to: 'budget_items#new',as: 'new_budget_item'
  post 'travels/:id/budget_items', to: 'budget_items#create'
  
  resources :paid_items, only: [:destroy, :update, :edit]
  get 'travels/:id/paid_items', to: 'paid_items#index',as: 'paid_items'
  get 'travels/:id/paid_items/new', to: 'paid_items#new',as: 'new_paid_item'
  post 'travels/:id/paid_items', to: 'paid_items#create'
  
end
