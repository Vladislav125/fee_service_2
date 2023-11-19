require "test_helper"

class EstatesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get estates_new_url
    assert_response :success
  end

  test "should get edit" do
    get estates_edit_url
    assert_response :success
  end

  test "should get show" do
    get estates_show_url
    assert_response :success
  end
end
