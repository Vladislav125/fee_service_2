class InspectorActionsController < ApplicationController
  before_action :inspector_or_admin_user, only: [:index, :show_user, :edit_user, :update_user]

  def index
    @users = User.order(:surname).page params[:page]
    @user = current_user
  end

  def users_list
    @users = User.order(:surname).page params[:page]
    render turbo_stream: turbo_stream.update('index', partial: 'users')
  end

  def estates_list
    @estates = Estate.order(:address).page params[:page]
    render turbo_stream: turbo_stream.update('index', partial: 'estates')
  end

  def vehicles_list
    @vehicles = Vehicle.order(:state_number).page params[:page]
    render turbo_stream: turbo_stream.update('index', partial: 'vehicles')
  end

  def organizations_list
    @organizations = Organization.order(:name).page params[:page]
    render turbo_stream: turbo_stream.update('index', partial: 'organizations')
  end

  def show_user
    @user = User.find(params[:id])
    @estates = Estate.where(user_id: @user.id)
    @vehicles = Vehicle.where(user_id: @user.id)
  end

  def edit_user
    @user = User.find(params[:id])
  end

  def update_user
    @user = User.find(params[:id])
    if @user.update_column(:income, params[:income])
      flash[:success] = "Данные профиля обновлены."
      redirect_to show_user_path(@user.id)
    else
      @errors = @user.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')    
    end
  end

  private

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end

    def user_params_for_edit
      params.require(:user).permit(:income)
    end
end
