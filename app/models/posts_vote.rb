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
  
   def ==(other_object)
    if (!self != nil && other_object != nil)
      if self.unique_identifier == other_object.unique_identifier && self.post_id == other_object.post_id
        if self.vote_bad != nil && other_object.vote_bad != nil
          if self.vote_bad == other_object.vote_bad
            return true
          end
        end
        
        if self.vote_good != nil && other_object.vote_good != nil
          if self.vote_good == other_object.vote_good
            return true
          end
        end
      end
    return false
    else
    return false
    end
  end
end
