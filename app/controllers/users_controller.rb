class UsersController < ApplicationController
  caches_page :new

  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :admin_user, only: :destroy
  before_action :inspector_or_admin_user, only: [:index, :show, :edit, :update]

  # GET /users or /users.json
  def index
    @users = User.order(:surname).page params[:page]
    @user = current_user
    
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
    @owner = current_user
    @flag = params[:field]
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if (params[:user_id] == 0)
      @user.organization = false
      @user.user_id = nil
    else
      @user.organization = true
      @user.user_id = params[:user_id]
    end
    if @user.save
      flash[:info] = "Учётная запись создана."
      log_out
      log_in @user
      redirect_to account_path
    else
      render :new, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    if @user.update(user_params_for_edit)
      flash[:success] = "Данные профиля обновлены."
      redirect_to show_user_path(@user.id)
    else
      render :edit, status: :unprocessable_entity, content_type: "text/html"
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Пользователь удалён"
    redirect_to users_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:snils, :password, :password_confirmation, :passport, :surname, :firstname, :middlename, :born_date, :address, :user_id)
    end

    def user_params_for_edit
      params.permit(:passport, :surname, :firstname, :middlename, :born_date, :address, :income)
    end

    # предварительные фильтры

    # подтвверждает вход пользователя
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Пожалуйста, авторизуйтесь."
        redirect_to login_path
      end
    end

    # подтверждает права пользователя
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin? || current_user.inspector?
    end

    # подтверждает наличие административных привилегий
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def inspector_or_admin_user
      redirect_to(root_path) unless current_user.inspector? || current_user.admin?
    end
end
