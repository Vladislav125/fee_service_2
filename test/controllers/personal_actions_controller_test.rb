require "test_helper"

class PersonalActionsControllerTest < ActionDispatch::IntegrationTest
  test "should get account" do
    get personal_actions_account_url
    assert_response :success
  end
end
