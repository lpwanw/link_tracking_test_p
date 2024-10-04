require "test_helper"

class LinkClickTest < ActiveSupport::TestCase
  setup do
    attributes = {
      anchor_text: Faker::Lorem.sentence,
      ip_address: Faker::Internet::PRIVATE_IPV4_ADDRESS_RANGES,
      user_agent: Faker::Lorem.sentence,
      referrer: Faker::Internet::HTTP
    }
    5.times { |i| LinkClick.create(attributes.merge(url: "/page#{i}", created_at: 2.days.ago)) }
    3.times { |i| LinkClick.create(attributes.merge(url: "/pagex", created_at: 1.day.ago)) }
    2.times { |i| LinkClick.create(attributes.merge(url: "/pagey", created_at: Date.today)) }
  end

  test "most_clicked_links returns the correct order and limit" do
    result = LinkClick.most_clicked_links(limit: 2)
    assert_equal 2, result.length
    assert_equal "/pagex", result.first.url
    assert_equal 3, result.first.click_counts
  end

  test "most_clicked_links with date range" do
    date_range = 1.day.ago.beginning_of_day..Time.current
    result = LinkClick.most_clicked_links(date_range: date_range, limit: 2)
    assert_equal 2, result.length
    assert_equal "/pagex", result.first.url
    assert_equal 3, result.first.click_counts
  end

  test "total_clicked_by_day returns correct counts and limits results" do
    result = LinkClick.total_clicked_by_day(limit: 2)
    assert_equal 2, result.size
    assert_equal 2, result.values.first
  end

  test "total_clicked_by_day with date range" do
    date_range = 2.days.ago.beginning_of_day...1.day.ago.end_of_day
    result = LinkClick.total_clicked_by_day(date_range: date_range, limit: 1)

    assert_equal 1, result.size
    assert_equal 3, result.values.first
  end

  test "total_click returns correct count" do
    assert_equal 10, LinkClick.total_click
  end

  test "total_click with date range" do
    date_range = 1.day.ago.beginning_of_day..Time.current
    assert_equal 5, LinkClick.total_click(date_range: date_range)
  end
end
