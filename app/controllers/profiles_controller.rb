# ユーザープロフィールに関するコントローラ
class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]
  before_action :set_user, only: %i[edit update]

  def show; end

  def edit; end

  def update
    ActiveRecord::Base.transaction do
      if @user.update(user_params.except(:profile)) && @profile.update(user_params[:profile])
        redirect_to profile_path, success: 'プロフィールを更新しました'
      else
        flash.now[:danger] = 'プロフィールの更新に失敗しました'
        render :edit, status: :unprocessable_entity
        raise ActiveRecord::Rollback
      end
    end
  end

  private

  def set_profile
    @profile = current_user.profile
  end

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :name, profile: %i[avatar week_goal mantra_config])
  end
end
