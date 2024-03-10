class UsersController < ApplicationController
  skip_before_action :first_access_today?
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @profile = Profile.new(user: @user)
    ActiveRecord::Base.transaction do
      if @user.save && @profile.save
        redirect_to new_daily_note_path, success: 'ユーザーを登録しました'
      else
        flash.now[:danger] = 'ユーザー登録に失敗しました'
        render :new, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    @user = current_user
    if @user.destroy
      redirect_to root_path,status: :see_other, success: 'ユーザーを削除しました'
    else
      flash.now[:danger] = 'ユーザーの削除に失敗しました'
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(%i[name email password password_confirmation])
  end
end



