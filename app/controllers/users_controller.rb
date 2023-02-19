class UsersController < ApplicationController
  # before_action :set_user, only: %i[ show update destroy ]
  # skip_before_action :authorize, only: :create

  # GET /users
  def index
    @users = User.all
    render json: @users
  end
  
  # user = User.find_by_id(session[:user_id])
  # GET /users/1
  def show
    @current_user ||= User.find_by_id(session[:user_id])
    if @current_user
      render json: @current_user
    else 
      render json: "Not authenticated", state: :unauthorized
    end
  end

  # GET /users/find/username
  def find_party
    # begin
    #   user = User.find_by(username: params[:username])
    #   coor = {lat: user.lat, lng: user.lng}
    #   render json: coor, status: :accepted
    # rescue ActiveRecord::RecordNotFound => e
    #   render json: { error: "#{e.model} not found" }, status: :not_found
    # end
    user = User.find_by(username: params[:username])
    if user
      coor = {lat: user.lat, lng: user.lng}
      render json: coor, status: :accepted
    else 
      render json: { error: "User not found" }, status: :not_found
    end
  end

  # POST /users
  def create
    @user = User.new(create_user)
    if @user.save
      session[:user_id] = @user.id
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def create_user
      params.permit(:username, :email, :password, :password_confirmation)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password,:avatar,:phone, :email, :address, :state, :zipcode, :lat, :lng)
    end
end






 # user = User.find_by(id: session[:user_id])
    # if user.update(patch_params)
    #   render json: user, status: :created
    # else 
    #   render json: {error: user.errors.full_messages}
    # end