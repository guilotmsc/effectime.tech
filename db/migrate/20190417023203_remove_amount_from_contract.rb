class RemoveAmountFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :amount, :decimal
  end
end
