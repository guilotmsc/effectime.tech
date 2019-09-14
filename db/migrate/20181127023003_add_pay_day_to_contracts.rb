class AddPayDayToContracts < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :payday, :integer
  end
end
