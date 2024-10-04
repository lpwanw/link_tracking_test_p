class Admin::DashboardController < BaseAdminController
  before_action :load_most_click_links


  def index
  end

  private

  def load_most_click_links
    @most_clicked_links = LinkClick.most_clicked_links
  end
end
