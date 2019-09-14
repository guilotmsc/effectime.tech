class CorporationUser < ApplicationRecord
  belongs_to :corporation
  belongs_to :user
end
