class InspectorActionsController < ApplicationController
  before_action :inspector_or_admin_user, only: [:index, :show_user]

  def index
    @users = User.order(:surname).page params[:page]
    @user = current_user
  end

  def show_user
    @user = User.find(params[:id])
  end

  private

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
