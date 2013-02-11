class User < ActiveRecord::Base
  attr_accessible :age, :email, :likes, :name, :others
end
