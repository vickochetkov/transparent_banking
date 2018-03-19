class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product

  def friendly_created_at
    updated_at.strftime("%b %d, %Y")
  end 

  def as_json
    {
      id: id,
      user_id: user_id,      
      product_id: product_id,
      stars: stars,
      text: text,
      created_at: friendly_created_at,
      user: user.as_json   
    }    
  end

end
