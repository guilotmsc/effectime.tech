class AddAreaFromProject < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :area, foreign_key: true
  end
end
