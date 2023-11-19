class EstatesController < ApplicationController
  def new
    @user_id = params[:id]
    @estate = Estate.new
  end

  def create
    @estate = Estate.new(estate_params)
    if @estate.save
      flash[:info] = "Информация о недвижимости дрбавлена."
      redirect_to estate_path(@estate.id)
    else
      @errors = @estate.errors.map(&:message)
      render turbo_stream: turbo_stream.update('errors', partial: 'errors')
    end
  end

  def destroy
    Estate.find(params[:id]).destroy
    flash[:success] = "Информация о недвижимости удалена."
    redirect_to index_path
  end

  def edit
  end

  def show
    @estate = Estate.find(params[:id])
  end

  private

    def estate_params
      params.permit(:user_id, :cadastral_number, :square, :cost, :estate_type, :reg_date, :address)
    end
end
