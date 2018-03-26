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
    if not_guest_user?     
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

    def update
    review = Review.find_by(id: params[:id])
    if review.update(
      user_id: params[:user_id] || review.user_id,
      product_id: params[:product_id] || review.product_id,
      stars: params[:stars] || review.stars,
      text: params[:text] || review.text
      )
      render json: review.as_json
     else
      render json: { errors: review.errors.full_messages}, status: 422
     end       
  end

  def destroy
    review = Review.find_by(id: params[:id])
    review.destroy
    render json: {message: "Review successfully deleted"}    
  end

end
