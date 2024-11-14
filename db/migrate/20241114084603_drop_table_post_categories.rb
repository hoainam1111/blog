class DropTablePostCategories < ActiveRecord::Migration[7.2]
  def change
    drop_table :post_categories
  end
end
