class AddCorporationToProject < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :corporation, foreign_key: true
  end
end
