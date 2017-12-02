Rails.application.routes.draw do
  resources :devices
  resources :measurements
  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'dashboard/data', to: 'dashboard#data', as: 'data'
  root :to => 'dashboard#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
