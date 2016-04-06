class RemoveTimestampsFromUsers < ActiveRecord::Migration
  def change
    remove_timestamps(:users, null: false)
  end
end
