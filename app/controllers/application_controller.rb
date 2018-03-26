class ApplicationController < ActionController::API
  include Knock::Authenticable

  def not_guest_user?
    if current_user != User.find(8)
      return true
    end   
  end

  # def authenticate_user
  #   unless current_user
  #     render json: {message: "You must be logged in to do that"}, status: :unauthorized
  #   end
  # end
    
end
