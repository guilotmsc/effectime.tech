class AddContractTypeToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :contract_type, :string
  end
end
