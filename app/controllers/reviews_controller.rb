class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show update destroy ]

  # GET /reviews
  def index
    @reviews = Review.all

    render json: @reviews
  end

  # GET /reviews/1
  def show
    render json: @review
  end

  # POST /reviews
  def create
    #Should only be able to review after exchange time passed

    exchange_time = Exchange.find(params[:exchange_id]).meettime

    date_exchange_time = Date.exchange_time
    if (date_exchange_time < Time.new)

      @review = Review.new(review_params)

      if @review.save
        render json: @review, status: :created, location: @review
      else
        render json: @review.errors, status: :unprocessable_entity
      end
    else  
      render json: {error: "Wait until #{exchange_time.strftime('%m/%d/%Y %I:%M %p')}"}
  end

  # PATCH/PUT /reviews/1
  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  def destroy
    @review.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:reviewer_id, :reviewed_id, :exchange_id, :rating, :content)
    end
end
