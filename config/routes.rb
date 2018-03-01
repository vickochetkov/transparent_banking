Rails.application.routes.draw do

  get "/products" => "products#index"
  get "/products/:id" => "products#show"
  post "/products" => "products#create"
  patch "/products/:id" => "products#update"
  delete "/products/:id" => "products#destroy"

  get "/reviews" => "reviews#index"
  get "/reviews/:id" => "reviews#show"  
  post "/reviews" => "reviews#create"
  patch "/reviews/:id" => "reviews#update"
  delete "/reviews/:id" => "reviews#destroy"

  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  post "/users" => "users#create"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/banks" => "banks#index"
  get "/banks/:id" => "banks#show"
  post "/banks" => "banks#create"
  patch "/banks/:id" => "banks#update"
  delete "/banks/:id" => "banks#destroy"

  get "/categories" => "categories#index"
  get "/categories/:id" => "categories#show"
  post "/categories" => "categories#create"
  patch "/categories/:id" => "categories#update"
  delete "/categories/:id" => "categories#destroy"
  
end
