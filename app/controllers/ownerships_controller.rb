class OwnershipsController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy, :edit, :update]

  # def new
  #   @ownership =  Ownership.new
  #   if params[:object_type] == "vehicle"
  #     @object = Vehicle.find(params[:object_id])
  #     @type = "vehicle"
  #   elsif params[:object_type] == "estate"
  #     @object = Estate.find(params[:object_id])
  #     @type = "estate"
  #   else
  #     @object = User.find(params[:object_id])
  #     @type = "income"
  #   end
  # end

  def new_for_vehicle_or_estate
    @ownership = Ownership.new
    if params[:object_type] == "vehicle"
      @object = Vehicle.find(params[:object_id])
      @type = "vehicle"
    elsif params[:object_type] == "estate"
      @object = Estate.find(params[:object_id])
      @type = "estate"
    end
  end

  def new_for_income
    @ownership = Ownership.new
    @object = User.find(params[:object_id])
    @type = "income"
  end

  def create
    if params[:object_type] != "income"
      inn = params[:inn]
      if !inn.match?(/\A(\d{10})|(\d{12})\z/)
        flash[:danger] = "Поле ИНН заполнено некорректно."
        redirect_to create_ownership_path(params[:object_type], params[:object_id])
      elsif User.find_by(inn: inn) == nil
        flash[:danger] = "Нет пользователя с таким ИНН."
        redirect_to create_ownership_path(params[:object_type], params[:object_id])
      end
    end
    @ownership = Ownership.new(ownership_params)
    if params[:object_type] == "vehicle"
      @ownership.vehicle_id = params[:object_id]
      @ownership.estate_id = nil
      @ownership.user_id = User.find_by(inn: inn).id
    elsif params[:object_type] == "estate"
      @ownership.estate_id = params[:object_id]
      @ownership.vehicle_id = nil
      @ownership.user_id = User.find_by(inn: inn).id
    else
      @ownership.estate_id == nil
      @ownership.vehicle_id == nil
      @ownership.user_id = params[:object_id]
    end
    if @ownership.save
      flash[:info] = "Информация о периоде налогообложения дрбавлена."
      if params[:object_type] == "vehicle"
        redirect_to vehicle_path(@ownership.vehicle_id)
      elsif params[:object_type] == "estate"
        redirect_to estate_path(@ownership.estate_id)
      else
        redirect_to show_user_path(@ownership.user_id)
      end
    else
      @errors = @ownership.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    Ownership.find(params[:id]).destroy
    flash[:success] = "Информация о периоде налогообложения удалена."
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
      params.permit(:reg_date, :end_date, :income)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
