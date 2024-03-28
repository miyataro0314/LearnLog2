require 'rails_helper'

RSpec.describe 'DailyNote', type: :system do
  let(:user) { create(:user) }

  describe 'デイリーノート作成' do
    context '今日のデイリーノートが作成されていない時、作成画面に移行するか' do
      it 'ログイン時' do
        login(user)
        expect(page).to have_current_path new_daily_note_path
      end
    end
  end
end