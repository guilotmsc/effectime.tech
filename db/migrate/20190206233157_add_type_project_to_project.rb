class AddTypeProjectToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :type_project, :string
  end
end
