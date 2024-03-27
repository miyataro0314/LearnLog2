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
  describe 'アソシエーションチェック' do
    it '関連付けられたユーザーが無い時にエラーとなるか' do
      mantra = build(:mantra)
      expect(mantra).to be_invalid
    end
  end
end
