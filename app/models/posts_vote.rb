class PostsVote < ActiveRecord::Base
  attr_accessible :set_spam, :unique_identifier, :vote_bad, :vote_good
end
