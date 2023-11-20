require "test_helper"

class ServiceVehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get service_vehicles_new_url
    assert_response :success
  end

  test "should get show" do
    get service_vehicles_show_url
    assert_response :success
  end
end
