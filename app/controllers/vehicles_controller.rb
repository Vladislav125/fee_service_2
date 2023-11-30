class VehiclesController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit]

  def new
    @user_id = params[:id]
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    if @vehicle.save
      flash[:info] = "Информация о транспортном средстве дрбавлена."
      redirect_to vehicle_path(@vehicle.id)
    else
      @errors = @vehicle.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    Vehicle.find(params[:id]).destroy
    flash[:success] = "Информация о транспортном средстве удалена."
    redirect_to index_path
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    if @vehicle.update(vehicle_params)
      flash[:success] = "Данные о транспортном средстве обновлены."
      redirect_to vehicle_path(@vehicle.id)
    else
      render :edit, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def show
    @vehicle = Vehicle.find(params[:id])
    @user = User.find(@vehicle.user_id)
  end

  private

    def vehicle_params
      params.permit(:user_id, :vin, :state_number, :model, :power, :vehicle_type, :reg_date)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
