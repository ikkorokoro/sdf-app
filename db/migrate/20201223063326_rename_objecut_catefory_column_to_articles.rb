class RenameObjecutCateforyColumnToArticles < ActiveRecord::Migration[6.0]
  def change
    rename_column :articles, :objecut, :object
    rename_column :articles, :catefory, :category
  end
end
