# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string(255)      not null
#  name          :string(255)      not null
#  age           :integer          not null
#  former_job    :string(255)      not null
#  total_tally   :integer          default(0)
#  total_good    :integer          default(0)
#  total_bad     :integer          default(0)
#  reported_spam :integer          default(0)
#  permalink     :string(255)
#  verified      :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  entry         :text
#

class Post < ActiveRecord::Base
  attr_accessible :age, :former_job, :name, :permalink, 
                  :reported_spam, :title, :total_bad,
                  :total_good, :total_tally, :user, 
                  :verified, :entry,
                  :queued
            
  validates :name, :presence => true
  validates :age, :presence => true
  validates :former_job, :presence => true
  validates :title, :presence => true
  validates :entry, :presence => true
                  
  #Set a permalink based on the timestamp before sending
#  before_save do
    #self.permalink = Digest::MD5.hexdigest(Time.zone.now.to_s)
#  end
  
  has_one :post_queue, :dependent => :destroy
  
  belongs_to :user
  
  def self.queue_top
    
    post = Post.where(:queued => FALSE).order("total_tally DESC").first
    
    if (post != nil)
      PostQueue.create(post: post, pushed: FALSE)
      
      post.queued = TRUE
      post.save
    end
  end
  
end
