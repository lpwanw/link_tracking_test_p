require "test_helper"

class ClickTrackingTest < ActionDispatch::IntegrationTest
  test "can see the posts page" do
    get "/posts"

    assert_response :success

    assert_equal 0, LinkClick.count

    click_on "Show this post"

    assert_equal 1, LinkClick.count
  end
end
