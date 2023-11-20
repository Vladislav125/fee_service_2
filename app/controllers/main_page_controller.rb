class MainPageController < ApplicationController
  def home
    @service_vehicles = ServiceVehicle.all
  end
end
