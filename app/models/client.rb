class Client < ApplicationRecord
	belongs_to :corporation
	has_many :contracts, dependent: :destroy
	has_many :projects, dependent: :destroy
end
