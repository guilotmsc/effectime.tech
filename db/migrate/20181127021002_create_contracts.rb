class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.string :client
      t.string :trading_name
      t.date :signature_date
      t.float :amount
      t.float :amount_ticket
      t.date :date_closing_hours
      t.date :payday
      t.string :email
      t.string :phone
      t.integer :hours_volume
      t.string :attribuition_model
      t.integer :tolerance

      t.timestamps
    end
  end
end
