require "test_helper"

class PlanControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get plan_index_url
    assert_response :success
  end

  test "should get show" do
    get plan_show_url
    assert_response :success
  end
end
