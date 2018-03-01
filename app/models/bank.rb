class Bank < ApplicationRecord

  has_many :products

  def as_json
    {
      id: id,
      title: title,      
      url: url,
      info: info,
      brand_img_url: brand_img_url      
    }    
  end

end
