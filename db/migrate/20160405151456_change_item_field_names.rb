class ChangeItemFieldNames < ActiveRecord::Migration
  def change
    rename_column :items, :title, :subtitle
    rename_column :items, :name, :title
  end
end
