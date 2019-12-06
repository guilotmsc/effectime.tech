class AddCodeToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :code, :string
  end
end
