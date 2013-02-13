# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  age        :integer
#  likes      :string(255)
#  others     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  email      :string(255)
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
