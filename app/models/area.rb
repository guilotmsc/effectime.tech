class Area < ApplicationRecord
   belongs_to :corporation, optional: true
   has_many :process_depts, dependent: :destroy
   has_many :projects, dependent: :destroy

   	def self.create_process(params, id)
		params.each do |p|
			unless p.blank?
				ProcessDept.create(:name => p, :area_id => id)
			end 
		end
	end
end
