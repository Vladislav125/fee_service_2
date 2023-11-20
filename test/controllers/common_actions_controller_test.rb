require "test_helper"

class CommonActionsControllerTest < ActionDispatch::IntegrationTest
  test "should get clear_business" do
    get common_actions_clear_business_url
    assert_response :success
  end
end
