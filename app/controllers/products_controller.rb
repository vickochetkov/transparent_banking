class ProductsController < ApplicationController

  def index
    products = Product.all.order(id: :asc)

    search_t = params[:search]
    if search_t 
      products = products.where("name LIKE ?", "%#{search_t}%")
    end

    price_order = params[:price]
    if price_order
      products = Product.all.order(price: :asc)
    end
      
    render json: products.as_json
  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product.as_json    
  end

  def create    
    product = Product.new(
      name: params[:name],
      price: params[:price],      
      description: params[:description],
      availability: params[:availability],
      supplier_id: params[:supplier_id]
      )

    if product.save
      render json: product.as_json
    else
      render json: { errors: product.errors.full_messages}, status: 422 
    end      
  end

  def update
    product = Product.find_by(id: params[:id])
    if product.update(
      name: params[:name] || product.name,
      price: params[:price] || product.price,      
      description: params[:description] || product.description,
      availability: params[:availability] || product.availability
      )
      render json: product.as_json
     else
      render json: { errors: product.errors.full_messages}, status: 422
     end       
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render json: {message: "Item successfully deleted"}    
  end
  
end
