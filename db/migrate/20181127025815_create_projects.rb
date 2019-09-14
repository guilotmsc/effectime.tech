class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.references :contract, foreign_key: true
      t.string :area
      t.string :sponsor
      t.string :manager
      t.string :objective
      t.date :start
      t.date :end
      t.float :estimate
      t.text :obs

      t.timestamps
    end
  end
end
