class User < ApplicationRecord
  has_many :reviews
  has_secure_password

  validates :first_name, presence: true
  validates :email, presence: true, uniqueness: true

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
      password: password,      
      email: email,
      image_url: image_url,
      date_of_birth: date_of_birth,
      total_reviews: reviews.size           
    }    
  end

end
