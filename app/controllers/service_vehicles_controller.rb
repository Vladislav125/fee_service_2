class ServiceVehiclesController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit]

  def new
    @organization_id = params[:id]
    @service_vehicle = ServiceVehicle.new
  end

  def create
    @service_vehicle = ServiceVehicle.new(service_vehicle_params)
    if @service_vehicle.save
      flash[:info] = "Информация о служебном транспортном средстве дрбавлена."
      redirect_to service_vehicle_path(@service_vehicle.id)
    else
      @errors = @service_vehicle.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    ServiceVehicle.find(params[:id]).destroy
    flash[:success] = "Информация о служебном транспортном средстве удалена."
    redirect_to index_path
  end

  def edit
  end

  def show
    @service_vehicle = ServiceVehicle.find(params[:id])
    @organization = Organization.find(@service_vehicle.organization_id)
  end

  private

    def service_vehicle_params
      params.permit(:organization_id, :state_number, :model, :power, :vehicle_type, :reg_date)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
