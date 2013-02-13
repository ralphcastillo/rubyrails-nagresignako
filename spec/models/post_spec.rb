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

require 'spec_helper'

describe Post do
  pending "add some examples to (or delete) #{__FILE__}"
end
