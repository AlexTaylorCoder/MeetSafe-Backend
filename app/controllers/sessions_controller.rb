class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create
  # post '/logout', to: 'sessions#create'
  # delete '/logout', to: 'sessions#destroy'

  #  create method in ruby means finding 
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    render json: user, status: :okay
  else
    render json: "Invalid Credentials. Try again!", state: :unauthorized
  end

  def destroy
    session.delete :user_id
  end
 
end








#  def create
#     user = User.find_by(email: params[:email])
#     if (user&.authenticate(params[:password]))
#       session[:user_id] = user.id
#       render json: user, status: 202
#     else
#       render json: {error: {login: "Invalid Username or Password"}}, status: 404
#     end
#     # rescue ActiveRecord::RecordInvalid => e
#     #   render json: {errors: 'Error Message'}, status: 404
#     # end
#   end

#   def destroy
#     session.delete :user_id
#     head :no_content
#   end

#   private

#   def authenticate (user, password)
#     if (user.password == password)
#       return true
#     else
#       return false
#     end
#   end