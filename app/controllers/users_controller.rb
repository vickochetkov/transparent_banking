class UsersController < ApplicationController

  def index
    users = User.all
    render json: users.as_json
  end

  def show
    # user = User.find_by(id: params[:id])
    user = current_user
    render json: user.as_json    
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: {message: 'User created successfully'}, status: :created
    else
      render json: {errors: user.errors.full_messages}, status: 422
    end
  end

  def update
    user = User.find_by(id: params[:id])
    if user.update(
      first_name: params[:first_name] || user.first_name,
      second_name: params[:second_name] || user.second_name,
      last_name: params[:last_name] || user.last_name,
      email: params[:email] || user.email,      
      image_url: params[:image_url] || user.image_url,      
      date_of_birth: params[:date_of_birth] || user.date_of_birth
      )
      render json: user.as_json
     else
      render json: { errors: user.errors.full_messages}, status: 422
     end       
  end

  def destroy
    user = User.find_by(id: params[:id])
    user.destroy
    render json: {message: "User successfully deleted"}    
  end

end
