class CommonActionsController < ApplicationController
  def clear_business

  end

  def find_business
    @identificator = params[:identificator]
    @user = User.find_by(inn: @identificator)
    if @user != nil && @user.ipid != nil
      render turbo_stream: turbo_stream.update('result', partial: 'result_inn')
    else
      render turbo_stream: turbo_stream.update('result', partial: 'not_found')
    end
    # render turbo_stream: turbo_stream.update('result_inn', partial: 'result_inn')    

  end
end
