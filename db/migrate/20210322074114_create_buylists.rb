class CreateBuylists < ActiveRecord::Migration[6.0]
  def change
    create_table :buylists do |t|
      t.references :user, null: :false
      t.references :rakuten, null: :false
      t.timestamps
    end
  end
end
