# == Schema Information
#
# Table name: daily_notes
#
#  id         :integer          not null, primary key
#  content    :text
#  date       :date             not null
#  mood       :integer
#  quote      :string
#  today_goal :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_daily_notes_on_date              (date)
#  index_daily_notes_on_user_id           (user_id)
#  index_daily_notes_on_user_id_and_date  (user_id,date) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe DailyNote, type: :model do
  describe 'アソシエーションチェック' do
    it '関連付けられたユーザーが無い時にエラーとなるか' do
      profile = build(:profile)
      expect(profile).to be_invalid
    end
  end
  describe 'バリデーションチェック' do
  end
end
