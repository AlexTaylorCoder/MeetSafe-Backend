class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      #To get credential Rails.credentials.twilio_key, Rails.credentials.twilio_sid
      #Send email async
      account_sid = Rails.application.credentials.twilio_sid
      auth_token = Rails.application.credentials.twilio_key
      @client = Twilio::REST::Client.new(account_sid, auth_token)

      @client.messages.create(
        from: '+19405319275',
        to: @user.phone, 
        body: "Hey, #{@user.username} welcome to meetSafe! You will recieve texts about upcoming exchanes." 
      )
      UserMailer.with(user:@user).welcome_email.deliver_later

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

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password,:avatar,:phone, :email, :address, :state, :zipcode, :lat, :lng)
    end
end
