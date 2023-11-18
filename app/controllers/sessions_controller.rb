class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(passport: params[:session][:passport])
    if user && user.authenticate(params[:session][:password])
      # if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      # else
        # message = "Account not activated."
        # message += "Check your email for the activation link."
        # flash[:warning] = message
        # redirect_to root_url
      # end
    else
      flash.now[:danger] = "Неверный логин или пароль"
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
