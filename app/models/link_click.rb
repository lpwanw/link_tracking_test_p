class LinkClick < ApplicationRecord
  def self.most_clicked_links(date_range: nil, limit: 10)
    query = select("url, COUNT(id) as click_counts")
    query = query.where(created_at: date_range) if date_range

    query.group(:url)
         .order("click_counts DESC")
         .limit(limit)
  end
end
