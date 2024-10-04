require "application_system_test_case"

class ClickTrackingsTest < ApplicationSystemTestCase
  test "Link click Tracking" do
    visit posts_url
    Rails.cache.delete(LinkClick::CACHE_KEY)

    click_link "New post"
    sleep 1
    assert_equal 1, Rails.cache.fetch(LinkClick::CACHE_KEY).count
  end
end
