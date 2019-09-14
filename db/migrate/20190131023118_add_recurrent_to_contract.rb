class AddRecurrentToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :recurrent_amount, :decimal
    add_column :contracts, :scope_ticket_amount, :decimal
  end
end
