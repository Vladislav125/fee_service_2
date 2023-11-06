class MainPageController < ApplicationController
  def home
    @users = User.all
  end
end
