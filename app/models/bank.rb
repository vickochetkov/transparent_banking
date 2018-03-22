class Bank < ApplicationRecord

  has_many :products

  def rating
    products_stars = (products.map { |product| product.reviews.average(:stars) }).select{|review| review != nil }
    return "no reviews" if products_stars.size == 0
    (products_stars.inject { |sum, el| sum + el }.to_f / products_stars.size).round(2)
  end

  def review_counter
    products_reviews = products.inject(0) { |sum, product| sum + product.reviews.size };
  end

  def bank_reviews
    reviews = []
    products.each do |product|
        reviews << product.reviews
    end
    return reviews.flatten    
  end

  def as_json
    {
      id: id,
      title: title,      
      url: url,
      info: info,
      brand_img_url: brand_img_url,
      products: products.map { |product| {id: product.id, name: product.name} },
      rating: rating,
      review_count: review_counter,
      reviews: bank_reviews.as_json
    }    
  end

end
