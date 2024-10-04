class Admin::DashboardController < BaseAdminController
  before_action :load_most_clicked_links, :load_total_clicked_by_day, :load_summary


  def index
  end

  private

  def load_most_clicked_links
    @most_clicked_links = Rails.cache.fetch("#{cache_key}_most_clicked_links", expires_in: 5.minutes) do
      LinkClick.most_clicked_links(date_range:)
    end
  end

  def load_total_clicked_by_day
    @total_clicked_by_day = Rails.cache.fetch("#{cache_key}_total_clicked_by_day", expires_in: 5.minutes) do
      LinkClick.total_clicked_by_day(date_range:)
    end
  end

  def load_summary
    @summary = Rails.cache.fetch("#{cache_key}_summary", expires_in: 5.minutes) do
      {
        total_click: LinkClick.total_click(date_range:)
      }
    end
  end

  def date_range
    @date_range ||= DateRangeFromParamsService.new(from: params[:from], to: params[:to]).call
  end

  def cache_key
    return "" unless date_range

    @cache_key ||= "#{params[:from]}_#{params[:to]}"
  end
end
