# == Schema Information
#
# Table name: posts_votes
#
#  id                :integer          not null, primary key
#  unique_identifier :string(255)
#  vote_good         :boolean
#  vote_bad          :boolean
#  set_spam          :boolean
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class PostsVote < ActiveRecord::Base
  attr_accessible :post_id, :set_spam, :unique_identifier, :vote_bad, :vote_good
end
