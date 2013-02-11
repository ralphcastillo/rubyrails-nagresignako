class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :email, :null => false, :unique => true
      t.string :password, :null => false
      t.string :repeat_password, :null => false
      t.string :name

      t.timestamps
    end
  end
end
