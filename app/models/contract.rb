class Contract < ApplicationRecord
  # belongs_to :employee, optional: true
  belongs_to :corporation
  has_many :appointments, dependent: :destroy
  has_many :projects, dependent: :destroy
end
