require "test_helper"

class TenkiyohoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tenkiyoho_index_url
    assert_response :success
  end
end
