class AddLikesFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :likes, :text
  end
end
