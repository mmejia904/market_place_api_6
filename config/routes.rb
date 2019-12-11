Rails.application.routes.draw do
  #API definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:show]
      #We are going to list our resources here 
    end
  end
end
