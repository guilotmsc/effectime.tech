class Corporation < ApplicationRecord
	belongs_to :corporation_type
	has_many :workspace_users, dependent: :destroy
	has_many :areas, dependent: :destroy
	has_many :contracts, dependent: :destroy
	has_many :projects, dependent: :destroy
end
