class RemoveStartFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :start, :date
  end
end
