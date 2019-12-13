Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'tokens/create'
    end
  end
  #API definition
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[show create update destroy]
      #We are going to list our resources here 

      resources :tokens, only: [:create]
    end
  end
end

# Te desired behavior is the following:
# I recieve a token if I send a valid email/password pair
# Otherwise server respond a forbidden response