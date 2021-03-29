Rails.application.routes.draw do
  get 'weather/forecast'
  get 'weather/current'
  resources :users, only: [:create, :destroy]
  resources :tokens, only: [:create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
