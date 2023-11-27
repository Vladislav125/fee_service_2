class CommonActionsController < ApplicationController
  def documents
  end 

  def declarations
  end
  
  def clear_business
  end

  def find_business
    identificator = params[:identificator]
    @result = User.find_by(inn: identificator)
    if @result != nil && @result.ipid != nil
      render turbo_stream: turbo_stream.update('result', partial: 'found')
    else
      render turbo_stream: turbo_stream.update('result', partial: 'not_found')
    end
  end
end
