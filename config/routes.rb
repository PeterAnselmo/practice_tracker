Rails.application.routes.draw do
  get "practices/landing/", to: "practices#landing"
  resources :practices
  resources :items
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "practices#landing"
end
