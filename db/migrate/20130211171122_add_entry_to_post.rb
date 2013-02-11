class AddEntryToPost < ActiveRecord::Migration
  def change
    add_column :posts, :entry, :text, :null => false
  end
end
