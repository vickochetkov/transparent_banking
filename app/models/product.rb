class Product < ApplicationRecord

  belongs_to :bank
  belongs_to :category
  has_many :reviews

  def as_json
    {
      id: id,
      name: name,
      category_id: category_id,      
      bank_id: bank_id,
      url: url,
      info: info,      
      status: status,      
      bank: bank.as_json,
      review_count: reviews.size,
      avrg_stars: reviews.average(:stars),
      reviews: reviews.as_json    
    }    
  end

end
