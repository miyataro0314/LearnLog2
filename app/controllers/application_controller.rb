# アプリケーション全体のコントローラ
class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  before_action :first_access_today?

  def first_access_today?
    return unless current_user.daily_notes.last&.date != Date.today

    redirect_to new_daily_note_path, info: '本日初めてのアクセスです。デイリーノートを作成してください。'
  end
end
