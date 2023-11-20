class PersonalActionsController < ApplicationController
  before_action :logged_in_user, only: [:account, :become_entrepreneur, :confirm_status]
  before_action :correct_user, only: [:account, :become_entrepreneur, :confirm_status]

  def account
    @user = current_user
  end

  def become_entrepreneur
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
    @organizations = Organization.where(user_id: @user.id)
  end

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Пожалуйста, авторизуйтесь."
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
