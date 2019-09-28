class AddWorkspaceToCorporation < ActiveRecord::Migration[5.1]
  def change
    add_reference :corporations, :workspace, foreign_key: true
  end
end
