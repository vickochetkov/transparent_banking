class Category < ApplicationRecord
  has_many :products  

  def as_json
    {
      id: id,
      title: title,
      products: products.map { |product| {id: product.id, name: product.name, review_count: product.reviews.size, rating: product.reviews.average(:stars).to_f.round(2), bank: product.bank } }.as_json
    }    
  end  

end
