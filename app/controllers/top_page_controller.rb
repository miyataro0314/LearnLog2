class TopPageController < ApplicationController
  before_action :check_first_access_of_the_day

  def new
    @logs = Log.today(current_user)
    @today_sum_time = Log.sum_time(current_user, Date.today)
    set_mantra(current_user)
  end

  private

  def set_mantra(user)
    return unless user.mantras.any?

    random_mantra = user.mantras.sample
    @mantra_author = random_mantra.author
    @mantra_body = random_mantra.body
  end
end
