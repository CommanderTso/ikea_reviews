class AddPictureUrlToItems < ActiveRecord::Migration
  def change
    rename_column :items, :url, :item_url
    add_column :items, :picture_url, :string, null: false
  end
end
