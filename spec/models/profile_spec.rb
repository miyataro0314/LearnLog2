# == Schema Information
#
# Table name: profiles
#
#  id            :integer          not null, primary key
#  avatar        :string
#  mantra_config :integer
#  week_goal     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'アソシエーションチェック' do
    it '関連付けられたユーザーが無い時にエラーとなるか' do
      profile = build(:profile)
      expect(profile).to be_invalid
    end
  end
  describe 'バリデーションチェック' do
  end
end
