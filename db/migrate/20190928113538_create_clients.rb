class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :trading_name
      t.string :document
      t.string :phone
      t.string :contact
      t.string :role
      t.string :contact_phone
      t.string :email

      t.timestamps
    end
  end
end
