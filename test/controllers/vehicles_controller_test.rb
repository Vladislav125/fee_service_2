require "test_helper"

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get vehicles_new_url
    assert_response :success
  end

  test "should get show" do
    get vehicles_show_url
    assert_response :success
  end
end
