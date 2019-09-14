class AddNameToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :name, :string
    add_column :contracts, :code, :string
    add_column :contracts, :scope, :text
  end
end
