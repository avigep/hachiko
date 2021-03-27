Rails.application.routes.draw do
  get 'weather/forecast'
  get 'weather/now'
  resources :users, only: [:index, :create, :show, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
