class EstatesController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit]

  def new
    @user_id = params[:id]
    @estate = Estate.new
  end

  def create
    @estate = Estate.new(estate_params)
    if @estate.save
      flash[:info] = "Информация о недвижимости дрбавлена."
      redirect_to estate_path(@estate.id)
    else
      @errors = @estate.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    Estate.find(params[:id]).destroy
    flash[:success] = "Информация о недвижимости удалена."
    redirect_to index_path
  end

  def edit
  end

  def show
    @estate = Estate.find(params[:id])
    @user = User.find(@estate.user_id)
  end

  private

    def estate_params
      params.permit(:user_id, :cadastral_number, :square, :cost, :estate_type, :reg_date, :address)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
