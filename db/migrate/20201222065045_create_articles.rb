class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.references :user, null: false
      t.string :objecut, null: false
      t.integer :price, null: false
      t.string :store, null: false
      t.string :catefory, null: false
      t.string :content, null: false
      t.timestamps
    end
  end
end
