class AddCategoryIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :category_id, :integer, null: false
  end
end
