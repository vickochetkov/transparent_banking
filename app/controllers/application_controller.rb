class ApplicationController < ActionController::API
  include Knock::Authenticable

  # def authenticate_user
  #   unless current_user
  #     render json: {message: "You must be logged in to do that"}, status: :unauthorized
  #   end
  # end
    
end
