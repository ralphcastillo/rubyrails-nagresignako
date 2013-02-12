class Post < ActiveRecord::Base
  attr_accessible :age, :former_job, :name, :permalink, :reported_spam, :title, :total_bad, :total_good, :total_tally, :user, :verified, :entry
  
  #Set a permalink based on the timestamp before sending
  before_save do
    self.permalink = Digest::MD5.hexdigest(Time.zone.now.to_s)
  end
  
end
