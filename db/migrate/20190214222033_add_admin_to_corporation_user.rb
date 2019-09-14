class AddAdminToCorporationUser < ActiveRecord::Migration[5.1]
  def change
    add_column :corporation_users, :admin, :boolean
  end
end
