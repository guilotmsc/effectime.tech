class RemoveAssociateFromProject < ActiveRecord::Migration[5.1]
  def change
    remove_column :projects, :associate, :boolean
  end
end
