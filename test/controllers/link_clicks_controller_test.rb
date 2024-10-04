require "test_helper"

class LinkClicksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get link_clicks_create_url
    assert_response :success
  end
end
