require "test_helper"

class BatchImportLinkClickJobTest < ActiveJob::TestCase
 include ActiveJob::TestHelper

  test "should fetch data from cache and insert into database" do
    click_data = [
        {
          url: "/",
          anchor_text: "Posts",
          referrer: "http://localhost:3000/admin",
          user_agent: "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) Ap...",
          ip_address: "::1"
        }
      ]

    perform_enqueued_jobs do
      Rails.cache.write(LinkClick::CACHE_KEY, click_data)

      BatchImportLinkClickJob.perform_later
    end

    assert_nil Rails.cache.read(LinkClick::CACHE_KEY)
    assert_equal 1, LinkClick.count
    assert_equal click_data.first[:url], LinkClick.last.url
  end

  test "should handle empty cache data gracefully" do
    perform_enqueued_jobs do
      Rails.cache.write(LinkClick::CACHE_KEY, [])

      BatchImportLinkClickJob.perform_later
    end

    assert_empty Rails.cache.read(LinkClick::CACHE_KEY)
    assert_equal 0, LinkClick.count
  end
end
