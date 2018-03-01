Bank.create!([
  {title: "Bank of America", url: "https://www.bankofamerica.com/", info: "A multinational banking and financial services corporation headquartered in Charlotte, North Carolina, United States. It is ranked 2nd on the list of largest banks in the United States by assets. As of 2016, Bank of America was the 26th largest company in the United States by total revenue. In 2016, it was ranked #11 on the Forbes Magazine Global 2000 list of largest companies in the world.", brand_img_url: "https://cached.imagescaler.hbpl.co.uk/resize/scaleWidth/815/cached.offlinehbpl.hbpl.co.uk/news/OMC/17A369AC-A930-824F-D143BB7CFF19AC97.jpg"},
  {title: "Chase Bank", url: "https://www.chase.com/", info: "A multinational bank.", brand_img_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Chase_logo_2007.svg/440px-Chase_logo_2007.svg.png"}
])
User.create!([
  {first_name: "Benjamin", second_name: "Crite", email: "boretz@gmail.com", password_digest: nil, image_url: nil, date_of_birth: nil, last_name: "Boretz"},
  {first_name: "David", second_name: nil, email: "letterman@gmail.com", password_digest: nil, image_url: nil, date_of_birth: nil, last_name: "Letterman"},
  {first_name: "Charles", second_name: "Sanders", email: "peirce@gmail.com", password_digest: nil, image_url: nil, date_of_birth: nil, last_name: "Peirce"},
  {first_name: "Jim", second_name: nil, email: "carrey@gmail.com", password_digest: nil, image_url: nil, date_of_birth: nil, last_name: "Carrey"}
])
Category.create!([
  {title: "Checking account"},
  {title: "Saving account"},
  {title: "Money transfer"},
  {title: "Student loan"}
])
Product.create!([
  {name: "Credit Card Visa Year", url: "#", info: "better suggestion", status: "active", category_id: nil, bank_id: 1},
  {name: "Debit Card Master Card Year", url: "###", info: "test", status: "active", category_id: nil, bank_id: 1},
  {name: "Saving Account", url: "#", info: "for students", status: "inactive", category_id: 2, bank_id: 1},
  {name: "Money Transfer", url: "#", info: "Dollar", status: "active", category_id: 3, bank_id: 1},
  {name: "Checking Account", url: "#", info: "for family", status: "active", category_id: 1, bank_id: 2}
])
Review.create!([
  {user_id: 1, product_id: 2, stars: 5, text: "very good service"}
])

