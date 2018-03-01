class Category < ApplicationRecord
  has_many :products

  def as_json
    {
      id: id,
      title: title      
    }    
  end  

end
