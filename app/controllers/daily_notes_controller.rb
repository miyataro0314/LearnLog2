# デイリーノートに関わるコントローラ
class DailyNotesController < ApplicationController
  before_action :require_login
  before_action :set_daily_note, only: %i[show edit update]
  skip_before_action :check_first_access_of_the_day, only: %i[new create]

  def new
    @daily_note = DailyNote.new
    render layout: false
  end

  def index
    @q = current_user.daily_notes&.includes(:logs)&.ransack(params[:q])
    @daily_notes = @q.result.order(created_at: :desc).page(params[:page])
  end

  def show
    @logs = @daily_note.logs
    @sum_time = Log.sum_time(user: current_user, date: @daily_note.date)
  end

  def edit; end

  def create
    @daily_note = current_user.daily_notes.build(daily_note_params.merge(date: Date.today))
    if @daily_note.save
      redirect_to root_path, success: 'デイリーノートを登録しました'
    else
      flash.now[:danger] = 'デイリーノートの登録に失敗しました'
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @daily_note.update(daily_note_params)
      redirect_to daily_note_path, success: 'デイリーノートを更新しました'
    else
      flash.now[:danger] = 'デイリーノートの更新に失敗しました'
      render 'edit', status: :unprocessable_entity
    end
  end

  def search_daily_notes
    @q = current_user.daily_notes&.includes(:logs)&.ransack(params[:q])
    @daily_notes = @q.result.order(created_at: :desc).page(params[:page])
  end

  private

  def daily_note_params
    params.require(:daily_note).permit(%i[today_goal quote mood content])
  end

  def set_daily_note
    @daily_note = DailyNote.find(params[:id])
  end
end
