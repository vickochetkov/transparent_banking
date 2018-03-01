class CreateBanks < ActiveRecord::Migration[5.1]
  def change
    create_table :banks do |t|
      t.string :title
      t.string :url
      t.text :info
      t.string :brand_img_url

      t.timestamps
    end
  end
end
