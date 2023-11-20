class ServiceEstatesController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit]

  def new
    @organization_id = params[:id]
    @service_estate = ServiceEstate.new
  end

  def create
    @service_estate = ServiceEstate.new(service_estate_params)
    if @service_estate.save
      flash[:info] = "Информация о служебной недвижимости дрбавлена."
      redirect_to service_estate_path(@service_estate.id)
    else
      @errors = @service_estate.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    ServiceEstate.find(params[:id]).destroy
    flash[:success] = "Информация о служебной недвижимости удалена."
    redirect_to index_path
  end

  def edit
  end

  def show
    @service_estate = ServiceEstate.find(params[:id])
    @organization = Organization.find(@service_estate.organization_id)
  end

  private

    def service_estate_params
      params.permit(:organization_id, :cadastral_number, :square, :cost, :estate_type, :reg_date, :address)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
