class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :article_number
      t.string :name, null: false
      t.string :url
      t.decimal :price, scale: 2, precision: 7
      t.string :title, null: false
      t.text :description

      t.timestamps null: false
    end
  end
end
