class AddUserFromPost < ActiveRecord::Migration
  def change
    add_column :posts, :user_id, :integer, :null => true
  end
end
