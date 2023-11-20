require "test_helper"

class ServiceEstatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get service_estates_new_url
    assert_response :success
  end

  test "should get show" do
    get service_estates_show_url
    assert_response :success
  end
end
