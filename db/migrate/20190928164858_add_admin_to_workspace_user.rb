class AddAdminToWorkspaceUser < ActiveRecord::Migration[5.1]
  def change
    add_column :workspace_users, :admin, :boolean
  end
end
