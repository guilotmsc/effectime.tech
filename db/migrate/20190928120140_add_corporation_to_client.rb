class AddCorporationToClient < ActiveRecord::Migration[5.1]
  def change
    add_reference :clients, :corporation, foreign_key: true
  end
end