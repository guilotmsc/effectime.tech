class AddClientToArea < ActiveRecord::Migration[5.1]
  def change
    add_reference :areas, :client, foreign_key: true
  end
end
