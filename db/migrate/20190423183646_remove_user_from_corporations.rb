class RemoveUserFromCorporations < ActiveRecord::Migration[5.1]
  def change
    remove_reference :corporations, :user, foreign_key: true
  end
end
