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
require 'rails_helper'

RSpec.describe Mantra, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
