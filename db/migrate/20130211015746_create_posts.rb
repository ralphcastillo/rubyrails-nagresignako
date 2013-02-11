class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, :null => false
      t.string :title, :null => false
      t.string :name, :null => false
      t.integer :age, :null => false
      t.string :former_job, :null => false
      t.integer :total_tally, :default => 0
      t.integer :total_good, :default => 0
      t.integer :total_bad, :default => 0
      t.integer :reported_spam, :default => 0
      t.string :permalink
      t.boolean :verified, :default => false

      t.timestamps
    end
  end
end
