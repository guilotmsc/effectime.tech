class HomeController < ApplicationController

  def index

      cp = Company.all.joins(:company_users).where("companies.id = company_users.company_id and company_users.user_id = #{current_user.id}").first

      if cp.present?
        redirect_to company_path(cp.id)
      else
        redirect_to '/home/not_found'
      end
  
  end

  def information
  	
  end
end
