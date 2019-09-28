class AddClientToContract < ActiveRecord::Migration[5.1]
  def change
    add_reference :contracts, :client, foreign_key: true
  end
end
