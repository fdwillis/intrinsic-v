Rails.application.routes.draw do
  get 'home/home'
  resources :stocks
  root to: "stocks#index"
end
