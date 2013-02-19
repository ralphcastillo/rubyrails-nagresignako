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

require 'spec_helper'

describe PostQueue do
  pending "add some examples to (or delete) #{__FILE__}"
end
