# 名言に関するコントローラ
class MantrasController < ApplicationController
  rescue_from ActiveRecord::ActiveRecordError, with: :handle_active_record_error
  before_action :set_mantra, only: %i[edit update destroy]

  def index
    @mantra = current_user.mantras.new
    @mantras = Mantra.where(user_id: current_user.id)
  end

  def create
    @mantra = current_user.mantras.new(mantra_params)
    @mantra.save!
  end

  def edit; end

  def update
    @mantra.update!(mantra_params)
  end

  def destroy
    @mantra.destroy!
  end

  private

  def set_mantra
    @mantra = Mantra.find(params[:id])
  end

  def mantra_params
    params.require(:mantra).permit(%i[author body])
  end

  def handle_active_record_error
    redirect_to mantras_path, danger: "処理中にエラーが発生しました。エラー内容：#{@mantra.errors.full_messages}"
  end
end
