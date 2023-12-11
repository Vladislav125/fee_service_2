class PersonalActionsController < ApplicationController
  before_action :logged_in_user, only: [:account, :become_entrepreneur, :confirm_status, :property]
  before_action :physical_user, only: [:become_entrepreneur, :create_business]

  def account
    @user = current_user
    @files = @user.files
  end

  def become_entrepreneur
    @user = current_user
  end

  def create_business
    @user = current_user
  end

  def confirm_status
    @user = current_user
    if @user.ipid == nil
      @user.generate_ipid
      flash[:success] = "Вы зарегистрированы как индивидуальный предприниматель."
      redirect_to account_path
    end
  end

  def fill_balance
    @user = current_user
  end

  def update_balance
    @user = current_user
    if @user.update(permitted_params)
      flash[:success] = "Баланс пополнен."
      redirect_to account_path
    else
      render :edit, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def property
    @user = current_user
    @ownerships = Ownership.where(user_id: @user.id)
    @current_ownerships = @ownerships.select { |object| object.end_date >= Date.parse("#{Time.now.year-1}-12-31") }
    @ownerships -= @current_ownerships
    @vehicles = @ownerships.map { |object| Vehicle.find(object.vehicle_id) unless object.vehicle_id.nil? }.uniq.compact
    @estates = @ownerships.map { |object| Estate.find(object.estate_id) unless object.estate_id.nil? }.uniq.compact
    @current_vehicles = @current_ownerships.map { |object| Vehicle.find(object.vehicle_id) unless object.vehicle_id.nil? }.uniq.compact
    @current_estates = @current_ownerships.map { |object| Estate.find(object.estate_id) unless object.estate_id.nil? }.uniq.compact
    @vehicles -= @current_vehicles
    @estates -= @current_estates
  end

  def send_files
  end

  def attach_files
    @user = current_user
    @user.files.attach(params[:files])
    flash[:info] = "Файлы загружены."
    redirect_to account_path
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Пожалуйста, авторизуйтесь."
        redirect_to login_path
      end
    end

    def physical_user
      if current_user.organization?
        redirect_to account_path
      end
    end

    def permitted_params
      params.permit(:balance)
    end
end
