class Appointment < ApplicationRecord
  	belongs_to :user
  	# belongs_to :employee, optional: true
    belongs_to :contract, optional: true
	belongs_to :project, optional: true
end
