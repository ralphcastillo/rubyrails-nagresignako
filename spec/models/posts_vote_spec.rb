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

require 'spec_helper'

describe PostsVote do
  pending "add some examples to (or delete) #{__FILE__}"
end
