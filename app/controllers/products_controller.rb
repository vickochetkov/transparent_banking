class ProductsController < ApplicationController

  def index
    products = Product.all#.bank(id: :asc)    
    render json: products.as_json

    search_t = params[:search]
      if search_t
        products = products.where("name LIKE ?", "%#{search_t}")
    end
  end

  def show
    product = Product.find_by(id: params[:id])
    render json: product.as_json    
  end

  def create    
    product = Product.new(
      name: params[:name],
      category_id: params[:category_id],      
      bank_id: params[:bank_id],
      url: params[:url],
      info: params[:info],
      status: params[:status]
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
      category_id: params[:category_id] || product.category_id,      
      bank_id: params[:bank_id] || product.bank_id,
      url: params[:url] || product.url,
      info: params[:info] || product.info,
      status: params[:status] || product.status
      )
      render json: product.as_json
     else
      render json: { errors: product.errors.full_messages}, status: 422
     end       
  end

  def destroy
    product = Product.find_by(id: params[:id])
    product.destroy
    render json: {message: "Product successfully deleted"}    
  end

end
