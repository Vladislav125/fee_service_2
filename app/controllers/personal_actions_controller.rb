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

  def property
    @user = current_user
    @vehicles = Vehicle.where(user_id: @user.id)
    @estates = Estate.where(user_id: @user.id)
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
end
