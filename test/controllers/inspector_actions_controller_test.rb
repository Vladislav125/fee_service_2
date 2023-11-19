require "test_helper"

class InspectorActionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get inspector_actions_index_url
    assert_response :success
  end

  test "should get show_user" do
    get inspector_actions_show_user_url
    assert_response :success
  end
end
