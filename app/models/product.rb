class Product < ApplicationRecord

  belongs_to :bank
  belongs_to :category

  def as_json
    {
      id: id,
      name: name,
      category_id: category_id,      
      bank_id: bank_id,
      url: url,
      info: info,
      total: total,
      status: status      
    }    
  end

end
