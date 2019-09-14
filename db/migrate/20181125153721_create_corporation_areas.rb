class CreateCorporationAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :corporation_areas do |t|
      t.references :corporation, foreign_key: true
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
