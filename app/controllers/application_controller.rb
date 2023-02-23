class ApplicationController < ActionController::API
  include ActionController::Cookies #controller inherits Cookies
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  before_action :validate_user, except: [:create]


  private

  def validate_user
    User.find_by(id: session[:user_id])
  end

  def record_invalid invalid
    render json: {errors: invalid.record.errors.full_messages}
  end

  def record_not_found invalid
    render json: {errors: invalid.message}
  end
  
end

# rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
#   before_action :authorize  
#   def authorize
#     @current_user = User.find_by(id: session[:user_id])
#     render json: {errors: ['Not Authorized']}, status: :unauthorized unless @current_user
#   end

#   def render_unprocessable_entity_response(exception)
#     render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
#   end
