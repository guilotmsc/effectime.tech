class ProcessDept < ApplicationRecord
  belongs_to :area

  has_many :appointments, dependent: :destroy
end
