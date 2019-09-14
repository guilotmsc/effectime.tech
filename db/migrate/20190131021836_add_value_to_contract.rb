class AddValueToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :input_value, :decimal
    add_column :contracts, :billing_date, :date
    add_column :contracts, :quota_amount, :decimal
    add_column :contracts, :quotas, :integer
    add_column :contracts, :quota_expiration_day, :integer
    add_column :contracts, :quota_billing_date, :date
  end
end
