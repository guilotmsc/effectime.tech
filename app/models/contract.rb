class Contract < ApplicationRecord
  # belongs_to :employee, optional: true
  belongs_to :corporation, optional: true
  belongs_to :client
  has_many :appointments, dependent: :destroy
  has_many :projects, dependent: :destroy
end
