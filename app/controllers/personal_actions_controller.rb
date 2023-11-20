class PersonalActionsController < ApplicationController
  before_action :logged_in_user, only: [:account]

  def account
    @user = current_user
  end

  def become_entrepreneur
  end

  def confirm_status
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
