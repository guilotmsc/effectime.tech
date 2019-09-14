class RemoveAreaFromProject < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :area, :string
  end
end
