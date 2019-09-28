class Workspace < ApplicationRecord
	belongs_to :corporation
  	belongs_to :user
end
