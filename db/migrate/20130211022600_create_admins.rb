class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email, :null => false, :unique => true
      t.string :password_digest, :null => false
      t.string :name
      t.string :role

      t.timestamps
    end
  end
end
