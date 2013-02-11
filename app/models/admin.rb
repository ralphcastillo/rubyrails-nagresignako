class Admin < ActiveRecord::Base
  attr_accessible :email, :name, :password, :repeat_password
end
