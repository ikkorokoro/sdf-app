class CreateRakutens < ActiveRecord::Migration[6.0]
  def change
    create_table :rakutens do |t|
      t.string :item_name 
      t.integer :item_price
      t.string :item_url
      t.string :image_urls
      t.integer :review_average
      t.string :shop_name
      t.string :genle_id
      t.timestamps
    end
  end
end
