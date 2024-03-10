class UserSessionsController < ApplicationController
  skip_before_action :first_access_today?
  
  def new; end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to root_path
    else
      flash.now[:danger] = 'ログインに失敗しました。メールアドレスもしくはパスワードが異なります。'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to root_path, status: :see_other
  end
end