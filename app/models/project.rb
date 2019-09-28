class Project < ApplicationRecord
	belongs_to :contract, optional: true
	belongs_to :corporation, optional: true
	belongs_to :client, optional: true

	has_many :appointments, dependent: :destroy
	has_and_belongs_to_many :users
end
