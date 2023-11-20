class PersonalActionsController < ApplicationController
  before_action :logged_in_user, only: [:account]

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
