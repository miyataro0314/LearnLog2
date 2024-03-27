# == Schema Information
#
# Table name: mantras
#
#  id         :integer          not null, primary key
#  author     :string
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_mantras_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'test_helper'

class MantraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
