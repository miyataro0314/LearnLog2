# 学習記録に関するコントローラ
class LogsController < ApplicationController
  before_action :require_login
  before_action :set_log, only: %i[edit update destroy]
  before_action :set_last_log, only: %i[new end]
  before_action :set_daily_note, only: :start
  skip_before_action :check_first_access_of_the_day, only: :end

  def new
    @logs = Log.today(current_user)
  end

  def index
    @q = current_user.logs.ransack(params[:q])
    @logs = @q.result.order(created_at: :desc).page(params[:page])
    @all_sum_time = Log.sum_time(current_user, Log.recorded_dates(current_user))
  end

  def edit; end

  def update
    if @log.update(log_params)
      redirect_to logs_path, success: '更新しました'
    else
      flash.now[:danger] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @log.destroy!
      redirect_to logs_path, status: :see_other, success: '削除しました'
    else
      flash.now[:danger] = '削除できませんでした'
      render :show, status: :unprocessable_entity
    end
  end

  def start
    return unless check_log_condition(should_exist: false, message: 'まだ計測が終了していません')

    log = Log.new(date: Date.today, start_at: Time.current, user: current_user, daily_note: @daily_note)
    if log.save
      redirect_to new_log_path, success: '計測を開始しました'
    else
      flash.now[:danger] = '計測を開始できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def end
    return unless check_log_condition(should_exist: true, message: 'まだ計測が開始されていません')

    @last_log.end_at = Time.current
    if @last_log.save
      redirect_to new_log_path, success: '計測を終了しました'
    else
      flash.now[:danger] = '計測を終了できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def search_logs
    @q = current_user.logs.ransack(params[:q])
    @logs = @q.result.order(created_at: :desc).page(params[:page])
    if params[:q][:form_type] == 'date_range_search'
      start_date = params[:q][:date_gteq] || current_user.created_at.to_date
      end_date  = params[:q][:date_lteq_end_of_day] || Date.today
      @sum_time = Log.sum_time(user: current_user, date: start_date..end_date)
    else
      @sum_time = Log.sum_time(user: current_user, date: params[:q][:date_eq].to_date)
    end
  end

  private

  def log_params
    params.require(:log).permit(%i[start_at end_at])
  end

  def set_log
    @log = Log.find(params[:id])
  end

  def set_last_log
    @last_log = current_user.logs&.last
  end

  def set_daily_note
    @daily_note = current_user.daily_notes.find_or_create_by(date: Date.today)
  end

  def check_log_condition(should_exist:, message:)
    # 測定開始時の呼び出しはsould_existをfalseに、終了時はtrueを指定する
    last_log = current_user.logs.last
    log_condition = last_log&.end_already? || !current_user.logs.exists?
    if should_exist == log_condition
      flash.now[:danger] = message
      redirect_to root_path
      return false
    end
    true
  end
end
