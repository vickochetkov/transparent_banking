class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :url
      t.text :info
      t.string :status
      t.integer :category_id
      t.integer :bank_id

      t.timestamps
    end
  end
end
