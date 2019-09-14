class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.references :contract, foreign_key: true
      t.references :project, foreign_key: true
      t.date :start
      t.date :end
      t.boolean :canceled, default: false
      t.text :description

      t.timestamps
    end
  end
end
