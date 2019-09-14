class RemoveEndFromProjects < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :end, :date
  end
end
