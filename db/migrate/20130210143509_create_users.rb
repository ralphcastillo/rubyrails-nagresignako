class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.integer :age
      t.string :likes
      t.text :others

      t.timestamps
    end
  end
end
