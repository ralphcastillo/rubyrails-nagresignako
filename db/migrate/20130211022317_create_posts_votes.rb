class CreatePostsVotes < ActiveRecord::Migration
  def change
    create_table :posts_votes do |t|
      t.string :unique_identifier
      t.boolean :vote_good
      t.boolean :vote_bad
      t.boolean :set_spam

      t.timestamps
    end
  end
end
