class RemoveLikesFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :likes
  end

  def down
    add_column :users, :likes, :string
  end
end
