class AddCorporationTypeToCorporation < ActiveRecord::Migration[5.1]
  def change
    add_reference :corporations, :corporation_type, foreign_key: true
  end
end
