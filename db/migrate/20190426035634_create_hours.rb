class CreateHours < ActiveRecord::Migration[5.1]
  def change
    create_table :hours do |t|
      t.references :corporation, foreign_key: true
      t.float :volume

      t.timestamps
    end
  end
end
