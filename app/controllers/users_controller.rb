class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    @current_user = User.find(session[:user_id])
    render json: @current_user
  end

  # POST /users
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {error: 'Email Taken, Please Login'}, status: 422
    end
  end
  # def create
  #   @user = User.new(user_params)

  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render json: @user.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /users/1
  def update
    user = User.find_by(id: session[:user_id])
    if user.update(patch_params)
      render json: user, status: :created
    else 
      render json: {error: user.errors.full_messages}
    end
    # if @user.update(user_params)
    #   render json: @user
    # else
    #   render json: @user.errors, status: :unprocessable_entity
    # end
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

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password_digest, :email, :address, :state, :zipcode, :lat, :lng)
    end
end
