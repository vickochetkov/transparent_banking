class ReviewsController < ApplicationController

  def index
    reviews = Review.all    
    render json: reviews.as_json
  end

  def show
    review = Review.find_by(id: params[:id])
    render json: review.as_json    
  end

  def create     
      review = Review.new(
        user_id: current_user.id,      
        product_id: params[:product_id],
        stars: params[:stars],
        text: params[:text]
      )
      if review.save
        render json: review.as_json 
      else
        render json: {errors: review.errors.full_messages}, status: 422
      end
    
  end

end
