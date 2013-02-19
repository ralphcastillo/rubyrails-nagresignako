class CreatePostQueues < ActiveRecord::Migration
  def change
    create_table :post_queues do |t|
      t.integer :post_id
      t.boolean :pushed

      t.timestamps
    end
  end
end
