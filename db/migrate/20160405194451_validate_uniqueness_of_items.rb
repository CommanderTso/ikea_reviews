class ValidateUniquenessOfItems < ActiveRecord::Migration
  def change
    add_index :items, :item_url, unique: true
  end
end
