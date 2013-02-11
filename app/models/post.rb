class Post < ActiveRecord::Base
  attr_accessible :age, :former_job, :name, :permalink, :reported_spam, :title, :total_bad, :total_good, :total_tally, :user, :verified, :entry
end
