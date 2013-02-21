class AddQueuedToPost < ActiveRecord::Migration
  def change
    add_column :posts, :queued, :boolean, :default => false
  end
end
