class ExchangesController < ApplicationController
  before_action :set_exchange, only: %i[ show update destroy ]

  # GET /exchanges
  def index
    @exchanges = Exchange.all

    render json: @exchanges
  end

  # GET /exchanges/1
  def show
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

  # POST /exchanges
  def create
    @exchange = Exchange.new(exchange_params)

    if @exchange.save
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
    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exchange_params
      params.permit(:invite_code, :address_1, :address_1_lat, :address_1_lng, :address_2, :address_2_lat, :address_2_lng, :meeting_address, :meeting_address_lat, :meeting_address_lng, :meettime)
    end

    def location_params 
      params.permit(:lat,:lng)
    end
end
