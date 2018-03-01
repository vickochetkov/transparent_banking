class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :second_name
      t.string :email
      t.string :password_digest
      t.string :image_url
      t.string :date_of_birth

      t.timestamps
    end
  end
end
