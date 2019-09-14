class CreateCorporationTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :corporation_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
