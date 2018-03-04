require 'unirest'

# admin = false

while true
  system "clear"

  puts "Welcome to the 'Transparent Banking'! Make your choice:"
  puts ""
  puts "[1] See all banks, categories or bank products sorted by id (asc)"  
  puts "[2] Search bank or product by name"
  
  #if admin
    puts "[3] Create a bank, product or category"
    puts "[4] Update a bank, product or category"
    puts "[5] Delete! a bank, product or category (CAREFUL!)"
  #end

  puts "[6] Signup"
  puts "[7] Login"
  puts "[8] Logout"    
  puts "[q] To quit"

  input_optn = gets.chomp

  if input_optn == "1"

    puts "Choose what to see:"
    puts "[1] See all banks"
    puts "[2] See all bank products"
    puts "[3] See all categories"

    user_choice = gets.chomp

    if user_choice == "1"

    response = Unirest.get("http://localhost:3000/banks")
    banks = response.body
    puts JSON.pretty_generate(banks)

    elsif user_choice == "2"

    response = Unirest.get("http://localhost:3000/products")
    products = response.body
    puts JSON.pretty_generate(products)

    elsif user_choice == "3"

    response = Unirest.get("http://localhost:3000/categories")
    categories = response.body
    puts JSON.pretty_generate(categories)  
    
    end  

  elsif input_optn == "2"

    puts "Choose what to see:"
    puts "[1] See all banks"
    puts "[2] See all bank products"    

    user_choice = gets.chomp

    if user_choice == "1"

    response = Unirest.get("http://localhost:3000/products?price=true")
    products = response.body
    puts JSON.pretty_generate(products)

  elsif input_optn == "1.2"
    puts "Enter search string: "
    search_t = gets.chomp
    puts "Here the matching item: "
    response = Unirest.get("http://localhost:3000/products?search=#{search_t}")
    item = response.body
    puts JSON.pretty_generate(item)  

  elsif input_optn == "1.3"
    puts "Enter product ID to show:"
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/products/#{input_id}")
    product = response.body
    puts JSON.pretty_generate(product)
    puts "Press enter to continue or type 'c' to add to cart"

    if gets.chomp == "c"

      puts "Enter quantity to add to cart: "
      quantity = gets.chomp
      params = {
        quantity: quantity,
        product_id: input_id
      }
      response = Unirest.post("http://localhost:3000/carted_products", parameters: params)
      carted_products = response.body
      puts JSON.pretty_generate(carted_products)
    end

  elsif input_optn == "1.4"
    puts "Enter the ID of the category:"
    input_id = gets.chomp
    response = Unirest.get("http://localhost:3000/categories/#{input_id}")
    category = response.body
    puts JSON.pretty_generate(category) 

  elsif input_optn == "3"

    puts "Make your choice for an object creation:"
    puts "[1] Create a supplier"
    puts "[2] Create an item"
    puts "[3] Create an image"

    user_choice = gets.chomp

    if user_choice == "1"

      params = {}
      puts "Enter a supplier name: "
      params[:name] = gets.chomp
      puts "Enter the supplier email: "
      params[:email] = gets.chomp
      puts "Enter the supplier phone_number: "
      params[:phone_number] = gets.chomp
      response = Unirest.post("http://localhost:3000/suppliers" , parameters: params)
      supplier = response.body
      puts JSON.pretty_generate(supplier)

    elsif user_choice == "2"

      params = {}
      puts "Enter an item name: "
      params[:name] = gets.chomp
      puts "Enter the item price: "
      params[:price] = gets.chomp    
      puts "Enter the item description: "
      params[:description] = gets.chomp
      puts "Enter the item availability: "
      params[:availability] = gets.chomp
      puts "Enter the Supplier ID: "
      params[:supplier_id] = gets.chomp
      response = Unirest.post("http://localhost:3000/products" , parameters: params)
      product = response.body
      puts JSON.pretty_generate(product)

     elsif user_choice == "3"
     
      params = {}
      puts "Enter the item image_url: "
      params[:image_url] = gets.chomp
      puts "Enter the Product ID: "
      params[:product_id] = gets.chomp    
      response = Unirest.post("http://localhost:3000/images" , parameters: params)
      image = response.body
      puts JSON.pretty_generate(image)

     end 

  elsif input_optn == "4"

    puts "Make your choice for an object update:"
    puts "[1] Update a supplier"
    puts "[2] Update an item"
    puts "[3] Update an image"

    user_choice = gets.chomp

    if user_choice == "1"

      params = {}
      puts "Enter the ID of the supplier to update:"
    suppl_id = gets.chomp
    response = Unirest.get("http://localhost:3000/suppliers/#{suppl_id}")
    supplier = response.body    
      puts "Update the supplier name (#{supplier['name']}): "
      params[:name] = gets.chomp
      puts "Update the supplier email (#{supplier['email']}): "
      params[:email] = gets.chomp
      puts "Update the supplier phone_number (#{supplier['phone_number']}): "
      params[:phone_number] = gets.chomp
      params.delete_if { |key, value| value.empty? }
      response = Unirest.patch("http://localhost:3000/suppliers/ #{suppl_id}" , parameters: params)    
      puts JSON.pretty_generate(response.body)

    elsif user_choice == "2"

    params = {}
    puts "Enter the ID of the item to update:"
    item_id = gets.chomp
    response = Unirest.get("http://localhost:3000/products/#{item_id}")
    item = response.body
    puts "Update the item name (#{item['name']}): "
    params[:name] = gets.chomp
    puts "Update the item price (#{item['price']}): "
    params[:price] = gets.chomp
    puts "Update the item image_url (#{item['image_url']}): "
    params[:image_url] = gets.chomp
    puts "Update the item description (#{item['description']}): "
    params[:description] = gets.chomp
    puts "Update the item availability (#{item['availability']}): "
    params[:availability] = gets.chomp
    params.delete_if { |key, value| value.empty? }
    response = Unirest.patch("http://localhost:3000/products/#{item_id}", parameters: params)
    updated_product = response.body
    puts JSON.pretty_generate(updated_product)

    elsif user_choice == "3"
         
    params = {}
    puts "Enter the ID of the image to update:"
    image_id = gets.chomp
    response = Unirest.get("http://localhost:3000/images/#{image_id}")
    image = response.body
    puts "Update the image url (#{image['image_url']}): "
    params[:image_url] = gets.chomp
    puts "Update the Product ID (#{image['product_id']}): "
    params[:product_id] = gets.chomp
    params.delete_if { |key, value| value.empty? } 
    response = Unirest.patch("http://localhost:3000/images/ #{image_id}" , parameters: params)    
    puts JSON.pretty_generate(response.body)

     end 

   elsif input_optn == "5"

    puts "Make your choice for an object deletion:"
    puts "[1] Delete a supplier"
    puts "[2] Delete an item"
    puts "[3] Delete an image"

    user_choice = gets.chomp

    if user_choice == "1"

      puts "Enter the id of the supplier to delete it forever"
      input_id = gets.chomp
      resp = Unirest.get("http://localhost:3000/suppliers/#{input_id}")
      supplier = resp.body
      puts "Are you sure deleting this supplier: '#{supplier ['name']}' y/n?"
      
      user_in = gets.chomp.downcase
        if user_in == "y"
          response = Unirest.delete("http://localhost:3000/suppliers/#{input_id}")
          puts JSON.pretty_generate(response.body)
        else
          puts "Have a nice day!" 
        end

    elsif user_choice == "2"
      puts "Enter the id of the item to delete it forever"
      input_id = gets.chomp
      response = Unirest.get("http://localhost:3000/products/#{input_id}")
      item = response.body
      puts "Are you sure deleting this item: '#{item['name']}' y/n?"
      
      user_in = gets.chomp.downcase
        if user_in == "y"
          response = Unirest.delete("http://localhost:3000/products/#{input_id}")
          puts JSON.pretty_generate(response.body)
        else
          puts "Have a nice day!" 
        end

    elsif user_choice == "3"

      puts "Enter the id of the image to delete it forever"
      input_id = gets.chomp
      resp = Unirest.get("http://localhost:3000/images/#{input_id}")
      image = response.body
      puts "Are you sure deleting this image: '#{image['id']}' y/n?"
      
      user_in = gets.chomp.downcase
        if user_in == "y"
          response = Unirest.delete("http://localhost:3000/products/#{input_id}")
          puts JSON.pretty_generate(response.body)
        else
          puts "Have a nice day!" 
        end

    end  

  elsif input_optn == "6"
    puts "Signup!"
    params = {}
    puts "Name: "
    params[:name] = gets.chomp
    puts "Email: " 
    params[:email] = gets.chomp
    puts "Password: "
    params[:password] = gets.chomp
    puts "Password confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users" , parameters: params)
    user = response.body
    puts JSON.pretty_generate(user)

  elsif input_optn == "7"
    puts "--- Login ---"
    puts "User email: "
    in_email = gets.chomp
    puts "User password: "
    in_password = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token", parameters: {auth: {email: in_email, password: in_password}})
    jwt = response.body["jwt"]
    # Save the JSON web token from the response 
    p jwt
    admin = response.body["admin"]
    p admin
    # Include the jwt in the headers of any future web requests
    Unirest.default_header("Authorization", "Bearer #{jwt}")

  elsif input_optn == "8"
    jwt = ""
    Unirest.clear_default_headers()

  elsif input_optn == "9"    
    puts "Create a new order: "
    puts "Enter Product ID: "    
    in_product_id = gets.chomp
    puts "Enter Product quantity: "
    in_quantity = gets.chomp
    response = Unirest.post("http://localhost:3000/orders", parameters: {product_id: in_product_id, quantity: in_quantity})
    order = response.body
    puts JSON.pretty_generate(order)

  elsif input_optn == "10"
    puts "Here are all your orders: "  
    response = Unirest.get("http://localhost:3000/orders")
    orders = response.body
    puts JSON.pretty_generate(orders)  

  elsif input_optn == "cart"
    puts "Here are all the items in your shopping cart: "  
    response = Unirest.get("http://localhost:3000/carted_products")
    items = response.body
    puts JSON.pretty_generate(items)
    puts "Press enter to continue or press 'o' to place the order, or press 'r' to remove a product"
    sub_option = gets.chomp

    if sub_option == 'o'
      response = Unirest.post("http://localhost:3000/orders")
      order = response.body
      puts JSON.pretty_generate(order)
    elsif sub_option == 'r'
      puts "Enter id of carted product to remove: "
      id = gets.chomp
      response = Unirest.delete("http://localhost:3000/carted_products/#{id}")
      puts JSON.pretty_generate(response.body)
    end

  elsif input_optn == "q"
    puts "Bye!"
    break
  end

  puts "Press enter key to continue"
  gets.chomp  
end














