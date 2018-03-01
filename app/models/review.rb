class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def as_json
    {
      id: id,
      user_id: user_id,      
      product_id: product_id,
      stars: stars,
      text: text      
    }    
  end

end
