class RemoveUserFromProject < ActiveRecord::Migration[5.1]
  def change
    remove_reference :projects, :user, foreign_key: true
  end
end
