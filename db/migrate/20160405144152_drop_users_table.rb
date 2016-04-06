class DropUsersTable < ActiveRecord::Migration
  def up
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :email, null: false
      t.string :password, null: false
    end
  end
end
