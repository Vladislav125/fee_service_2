class CommonActionsController < ApplicationController
  def clear_business
  end

  def find_business
    identificator = params[:identificator]
    @result = User.find_by(inn: identificator)
      
    if @result != nil && @user.ipid != nil
      render turbo_stream: turbo_stream.update('result', partial: 'entrepreneur')
    else
      @result = Organization.find_by(org_inn: identificator)
      if @result != nil
        render turbo_stream: turbo_stream.update('result', partial: 'organization')
      else
        render turbo_stream: turbo_stream.update('result', partial: 'not_found')
      end
    end
    # render turbo_stream: turbo_stream.update('result_inn', partial: 'result_inn')    

  end
end
