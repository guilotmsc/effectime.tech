class HomeController < ApplicationController

  def index
    cp = Corporation.all.joins(:corporation_users).where("corporations.id = corporation_users.corporation_id and corporation_users.user_id = #{current_user.id}").first

    if cp.present?
      redirect_to '/appointments'
    else
      redirect_to '/home/not_found'
    end
  end

  def information
  	
  end
end