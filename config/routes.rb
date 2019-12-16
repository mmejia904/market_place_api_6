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

class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    if @user&.authenticate(user_params[:password])
      render json: {
        token: JsonWebToken.encode(user_id: @user.id), 
        email: @user.email
      }
    else
      head :unauthorized
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end




# Te desired behavior is the following:
# I recieve a token if I send a valid email/password pair
# Otherwise server respond a forbidden response