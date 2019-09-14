class CreateCorporationUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :corporation_users do |t|
      t.references :corporation, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
