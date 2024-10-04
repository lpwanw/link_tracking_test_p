class LinkClicksController < ApplicationController
  protect_from_forgery except: :create

  def create
    click_data = Rails.cache.fetch(LinkClick::CACHE_KEY) { [] }
    click_data << link_click_params.to_h

    Rails.cache.write(LinkClick::CACHE_KEY, click_data)
    head :no_content
  end

  private

  def link_click_params
    params.required(:link_click).permit(:url, :anchor_text).merge(ip_address:, referrer:, user_agent:)
  end

  def ip_address
    request.remote_ip
  end

  def referrer
    request.referrer
  end

  def user_agent
    request.user_agent
  end
end
