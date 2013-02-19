class AddPostIdToPostsVotes < ActiveRecord::Migration
  def change
    add_column :posts_votes, :post_id, :integer
  end
end
