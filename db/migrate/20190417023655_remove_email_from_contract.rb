class RemoveEmailFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :date_closing_hours, :date
    remove_column :contracts, :email, :string
    remove_column :contracts, :phone, :string
    remove_column :contracts, :code, :string
  end
end
