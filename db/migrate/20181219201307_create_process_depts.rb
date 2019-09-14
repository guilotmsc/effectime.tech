class CreateProcessDepts < ActiveRecord::Migration[5.1]
  def change
    create_table :process_depts do |t|
      t.references :area, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
