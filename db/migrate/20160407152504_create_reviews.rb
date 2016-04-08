class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :description
      t.string :picture_url
      t.belongs_to :item, null: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
  end
end
