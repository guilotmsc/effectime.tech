class CreateWorkspaceUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :workspace_users do |t|
      t.references :workspace, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
