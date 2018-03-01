class User < ApplicationRecord
  has_many :reviews

  def full_name
    "#{first_name} #{second_name} #{last_name}"
  end

  def as_json
    {
      id: id,
      full_name: full_name,
      first_name: first_name,
      second_name: second_name,
      last_name: last_name,
      password_digest: password_digest,      
      email: email,
      image_url: image_url,
      date_of_birth: date_of_birth           
    }    
  end

end
