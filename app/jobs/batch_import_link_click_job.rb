class BatchImportLinkClickJob < ApplicationJob
  queue_as :default

  def perform
    click_data = Rails.cache.fetch(LinkClick::CACHE_KEY) { [] }
    Rails.logger.error("From Job: #{click_data}")
    return if click_data.blank?

    Rails.cache.delete(LinkClick::CACHE_KEY)

    LinkClick.transaction do
      LinkClick.insert_all(click_data)
    end
  end
end
