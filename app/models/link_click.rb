class LinkClick < ApplicationRecord
  CACHE_KEY = "click_data_batch".freeze

  def self.most_clicked_links(date_range: nil, limit: 10)
    query = select("url, COUNT(id) as click_counts")

    query = query.where(created_at: date_range) if date_range

    query.group(:url)
         .order("click_counts DESC")
         .limit(limit)
  end

  def self.total_clicked_by_day(date_range: nil, limit: 10)
    query = order(created_at: :desc)

    query = query.where(created_at: date_range) if date_range

    query.group("DATE(created_at)").limit(limit).count
  end

  def self.total_click(date_range: nil)
    return count unless date_range

    where(created_at: date_range).count
  end
end
