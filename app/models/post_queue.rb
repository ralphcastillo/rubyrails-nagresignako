# == Schema Information
#
# Table name: post_queues
#
#  id               :integer          not null, primary key
#  post_id          :integer
#  pushed           :boolean
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  timestamp_pushed :datetime
#

class PostQueue < ActiveRecord::Base
  attr_accessible :post_id, :pushed, :post
  belongs_to :post
end
