class AddRecurrentTicketsToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :recurrent_tickets, :integer
  end
end
