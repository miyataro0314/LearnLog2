# 静的ページに関するコントローラ
class StaticPagesController < ApplicationController
  skip_before_action :check_first_access_of_the_day

  def welcome; end
  def about; end

  def dashboard
    @days_count = count_all_days
    @achieving_goal_date = count_achieving_goal_date
    @daily_average = calc_daily_average
    @all_sum_time = Log.sum_time(user: current_user, date: current_user.created_at.to_date..Date.today)
  end

  private

  def count_achieving_goal_date
    count = 0
    current_user.daily_notes.each do |daily_note|
      achieved = Log.sum_time(user: current_user, date: daily_note.date)[:hours]
      count += 1 if daily_note.today_goal <= achieved
    end
    count
  end
end
