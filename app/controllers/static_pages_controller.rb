# 静的ページに関するコントローラ
class StaticPagesController < ApplicationController
  skip_before_action :first_access_today?, only: :top

  def top
    if logged_in?
      first_access_today?
      @logs = current_user.logs.where(date: Date.today)
      @today_sum_time = Log.calc_sum_time(user: current_user, date: Date.today)
      set_mantra
    else
      render 'before_login_top'
    end
  end

  def dashboard
    @days_count = count_all_days
    @achieving_goal_date = count_achieving_goal_date
    @daily_average = calc_daily_average
    @all_sum_time = Log.calc_sum_time(user: current_user, date: current_user.created_at.to_date..Date.today)
  end

  private

  def count_all_days
    [current_user.logs.select(:date).distinct.count, 1].max
  end

  def calc_daily_average
    days_count = count_all_days
    all_sum_time = Log.calc_sum_time(user: current_user, date: current_user.created_at.to_date..Date.today)
    raw_daily_average = all_sum_time[:raw] / days_count
    hours = (raw_daily_average / 3600).to_i
    minutes = ((raw_daily_average % 3600) / 60).to_i
    { hours:, minutes:, raw: raw_daily_average }
  end

  def count_achieving_goal_date
    count = 0
    current_user.daily_notes.each do |daily_note|
      achieved = Log.calc_sum_time(user: current_user, date: daily_note.date)[:hours]
      count += 1 if daily_note.today_goal <= achieved
    end
    count
  end

  def set_mantra
    return unless current_user.mantras.any?

    random_mantra = current_user.mantras.sample
    @author = random_mantra.author
    @body = random_mantra.body
  end
end
