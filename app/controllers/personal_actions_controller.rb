class PersonalActionsController < ApplicationController
  before_action :check_log_in, only: %i[account]

  def account
    @user = current_user
    @full_name = @user.surname + ' ' + @user.firstname
    if !@user.middlename.empty?
      @full_name += ' ' + @user.middlename
    end
  end

  private

    def check_log_in
      unless logged_in?
        redirect_to root_url
      end
    end
end
