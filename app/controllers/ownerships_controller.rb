class OwnershipsController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit, :update]

  def new
    @ownership =  Ownership.new
  end

  def create
    @ownership = Ownership.new(ownership_params)
    if @ownership.save
      flash[:info] = "Информация о периоде владения дрбавлена."
      redirect_to vehicle_path(@vehicle.id)
    else
      @errors = @ownership.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    Ownership.find(params[:id]).destroy
    flash[:success] = "Информация о периоде владения удалена."
    redirect_to index_path
  end

  def edit
  end

  def update
  end

  def show
  end

  private

    def ownership_params
      params.permit(:reg_date, :end_date)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
