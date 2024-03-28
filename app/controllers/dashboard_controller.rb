class DashboardController < ApplicationController
  def show
    @days_count = Log.recorded_dates(current_user).count
    @achieving_goal_date = count_achieving_goal_date
    @daily_average = Log.daily_average(current_user)
    @all_sum_time = Log.sum_time(current_user, Log.recorded_dates(current_user))
  end

  private

  def count_achieving_goal_date
    count = 0
    current_user.daily_notes.each do |daily_note|
      achieved = Log.sum_time(current_user, daily_note.date)[:hours]
      count += 1 if daily_note.today_goal <= achieved
    end
    count
  end
end
