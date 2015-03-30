Rails.application.routes.draw do
  #root will be the list of support tickets
  root "requests#index"

  #add the routes for support requests (requests)
  resources :requests

  #add a route for the search method
  get "/search" => "requests#search"

end
