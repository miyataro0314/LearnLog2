# == Schema Information
#
# Table name: logs
#
#  id            :integer          not null, primary key
#  date          :date             not null
#  end_at        :datetime
#  start_at      :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  daily_note_id :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_logs_on_daily_note_id  (daily_note_id)
#  index_logs_on_user_id        (user_id)
#
# Foreign Keys
#
#  daily_note_id  (daily_note_id => daily_notes.id)
#  user_id        (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Log, type: :model do
  let(:user) {create(:user)}
  let(:daily_note) {create(:daily_note, user_id: user.id) }

  describe 'アソシエーションチェック' do
    it '関連付けられたユーザーが無い時にエラーとなるか' do
      log = build(:log, daily_note_id: daily_note.id)
      expect(log).to be_invalid
    end
    it '関連付けられたデイリーノートが無い時にエラーとなるか' do
      log = build(:log, user_id: user.id)
      expect(log).to be_invalid
    end
  end

  describe 'バリデーションチェック' do
    context 'date' do
      it 'nilの時にエラーとなるか' do
        log = build(:log, user_id: user.id, daily_note_id: daily_note.id, start_at: nil, end_at: nil)
        expect(log).to be_invalid
      end
      it '開始時間より終了時間が以前の時にエラーとなるか' do
        log = build(:log, user_id: user.id, daily_note_id: daily_note.id, end_at: Time.current - 1.hour)
        expect(log).to be_invalid
      end
    end
  end
end
