class AddUserToCorporation < ActiveRecord::Migration[5.1]
  def change
    add_reference :corporations, :user, foreign_key: true
  end
end
