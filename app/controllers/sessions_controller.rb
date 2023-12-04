class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:field] == 'passport'
      user = User.find_by(passport: params[:session][:passport])
    else
      user = User.find_by(inn: params[:session][:inn])
    end
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or account_path
    else
      flash.now[:danger] = "Неверный логин или пароль"
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  def auth_choice
    case params[:field]
      when 'inn'
        render turbo_stream: turbo_stream.update('authorization', partial: 'form_with_inn')
      when 'passport'
        render turbo_stream: turbo_stream.update('authorization', partial: 'form_with_passport')
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
