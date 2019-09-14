class AddOverplusTicketAmountToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :overplus_ticket_amout, :decimal
    add_column :contracts, :extra_hour_amount, :decimal
  end
end
