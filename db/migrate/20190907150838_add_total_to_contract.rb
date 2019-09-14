class AddTotalToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :total, :decimal
    add_column :contracts, :recurring_amount_ticket, :decimal
  end
end
