class ReviewsController < ApplicationController

  def index
    reviews = Review.all    
    render json: reviews.as_json
  end

  def show
    review = Review.find_by(id: params[:id])
    render json: review.as_json    
  end

end
