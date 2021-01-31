class AddCategoryArticles < ActiveRecord::Migration[6.0]
  def change
    add_reference :articles, :category, null: false
  end
end
