class AddTimestampPushedToPostQueue < ActiveRecord::Migration
  def change
    add_column :post_queues, :timestamp_pushed, :timestamp
  end
end
