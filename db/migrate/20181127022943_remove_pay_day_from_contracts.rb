class RemovePayDayFromContracts < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :payday, :date
  end
end
