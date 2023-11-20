class OrganizationsController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit]

  def new
    @user_id = params[:id]
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      flash[:info] = "Информация об организации добавлена."
      redirect_to organization_path(@organization.id)
    else
      @errors = @organization.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    Organization.find(params[:id]).destroy
    flash[:success] = "Информация об организации удалена."
    redirect_to index_path
  end

  def edit
  end

  def show
    @organization = Organization.find(params[:id])
    @user = User.find(@organization.user_id)
    @service_vehicles = ServiceVehicle.where(organization_id: @organization.id)
    @service_estates = ServiceEstate.where(organization_id: @organization.id)
  end

  private

    def organization_params
      params.permit(:user_id, :name, :address, :income, :reg_date)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
