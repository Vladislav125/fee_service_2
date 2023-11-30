class NotificationsController < ApplicationController
  before_action :inspector_or_admin_user, only: [:new, :create, :destroy]

  def new
    @user = current_user
    @receiver = User.find(params[:receiver])
    @notification = Notification.new
  end

  def create
    @user = User.find(params[:user_id])
    @receiver = User.find(params[:receiver])
    @notification = Notification.new(notification_params)
    @notification.receiver = @receiver.id
    if @notification.save
      flash[:info] = "Уведомление отправлено."
      redirect_to show_user_path(@receiver.id)
    else
      @errors = @notification.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @receiver_id = @notification.receiver
    @notification.destroy
    flash[:success] = "Уведомление удалено."
    redirect_to show_user_path(@receiver_id)
  end

  def show
    @notification = Notification.find(params[:id])
    @user = User.find(@notification.user_id)
  end

  private

    def notification_params
      params.permit(:user_id, :receiver, :text_field)
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
