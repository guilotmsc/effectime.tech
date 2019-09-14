class AddCorporationToArea < ActiveRecord::Migration[5.1]
  def change
    add_reference :areas, :corporation, foreign_key: true
  end
end
