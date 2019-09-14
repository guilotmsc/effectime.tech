class AddAssociateToProject < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :associate, :boolean
  end
end
