class ExchangesController < ApplicationController
  before_action :set_exchange, only: %i[ show update destroy ]

  # GET /exchanges
  def index
    user = User.find(session[:user_id])
    @exchanges = user.exchanges
    render json: @exchanges
  end

  # GET /exchanges/1
  def show
    @exchange = Exchange.find(params[:id])
    user_exchanges = @exchange.user_exchanges

    hasExchange = user_exchanges.find_by(user_id: session[:user_id])

    if not hasExchange
      UserExchange.create!(user_id:session[:user_id],exchange_id:params[:id])
    end
    #need to see if 
    render json: @exchange
  end

  def check_location 
    exchange = Exchange.find(params[:exchange_id])

    
    positions = {
      meetup_lat: exchange.meeting_address_lat,
      meetup_lng: exchange.meeting_address_lng, 
      current_lat: params[:lat],
      current_lng: params[:lng],
    }
    if (exchange.meeting_address_lat - params[:lat]).abs < 10 and (exchange.meeting_address_lng - params[:lng]).abs < 10
      positions[:good] = true
      #Get user id from session 
      #Should use find
      current_user_exchange = exchange.user_exchanges.where("user_id = ?",)

      current_user_exchange.update!(present:true)
      render json: positions
    else
      positions[:good] = false
      render json: positions
    end

  end

  def join 
    #Need to redirect to app somehow
    #When user clicks link will redirect to frontend, then with id from frontend verifies against backend
    id = params[:id]

    render json: {link: "http://localhost:4000/exchange/#{id}"}

  end

  # POST /exchanges
  def create
    
    @exchange = Exchange.new(create_params)
    @exchange.invite_code = (Exchange.last.id + 1).to_s


    if @exchange.save
      UserExchange.create!(user_id:session[:user_id],exchange_id:@exchange.id)
      render json: @exchange, status: :created, location: @exchange
    else
      render json: @exchange.errors, status: :unprocessable_entity
    end
  end

  #If user doesn't show up give flag option
  #Should be avaible if 10 min past meettime, other user not in area, and current user in area
  def flag 
    exchange = Exchange.find(params[:id])

    reporterisValid = exchange.user_exchanges.find(params[:reporter_id]).present
    accusedisValid = exchange.user_exchanges.find(params[:accused_id]).present

    if reporterisValid and not accusedisValid
      if Time.now.to_i - exchange.meettime.to_i > 600000
        render json: {status: "Successfully Reported!"}

      else
        render json: {status: "Please wait until 10 minutes after meeting to report!"}
      end
    else  
      render json: {status: "You must be at the meetup location to report!"}
    end
      #can flag
    

  end

  # POST /exchanges/new_meeting/username
  def new_meeting
    party = User.find_by(username: params[:username])
    @exchange = Exchange.create!(new_meeting_params)
    UserExchange.create!(user_id:session[:user_id], exchange_id:@exchange.id)
    UserExchange.create!(user_id:party.id, exchange_id:@exchange.id)
    invite_message(party)

    render json: @exchange
  end

  # PATCH/PUT /exchanges/1
  def update
    if @exchange.update(exchange_params)
      render json: @exchange
    else
      render json: @exchange.errors, status: :unprocessable_entity
    end
  end

  # DELETE /exchanges/1
  def destroy
    @exchange.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions. 

    def invite_message party
      account_sid = "AC46488998e7476f389f1cb0eecbe75e23"
      auth_token = "429f0669f24e25dfb03e4c3fcb8de40f"
      user = User.find(session[:user_id])

      if user.phone
        @client = Twilio::REST::Client.new(account_sid, auth_token)

        @client.messages.create(
          from: '+19405319275',
          to: party.phone, 
          body: "You have invited to a new exchange at #{@exchange.meettime}"
        )
        @client.messages.create(
          from: '+19405319275',
          to: user.phone, 
          body: "You have created a new exchange at #{@exchange.meettime}"
        )
      end

      ExchangeMailer.with(exchange:@exchange).new_exchange.deliver_later

    end



    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exchange_params
      
      params.permit(:address_1, :address_1_lat, :address_1_lng, :address_2, :address_2_lat, :address_2_lng, :meeting_address, :meeting_address_lat, :meeting_address_lng, :meettime)
    end

    def create_params 
      params.permit(:address_1, :address_1_lat, :address_1_lng,:meettime)

    end

    def new_meeting_params
      
      params.permit(:address_1, :address_1_lat, :address_1_lng, :address_2, :address_2_lat, :address_2_lng, :meeting_address, :meeting_address_lat, :meeting_address_lng, :meettime, :details)
    end

    def location_params 
      params.permit(:lat,:lng)
    end
end
