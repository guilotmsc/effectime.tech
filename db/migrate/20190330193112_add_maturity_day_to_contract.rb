class AddMaturityDayToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :maturity_day, :integer
  end
end
