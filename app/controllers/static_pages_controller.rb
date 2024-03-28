# 静的ページに関するコントローラ
class StaticPagesController < ApplicationController
  skip_before_action :check_first_access_of_the_day

  def welcome; end

  def about; end
end
