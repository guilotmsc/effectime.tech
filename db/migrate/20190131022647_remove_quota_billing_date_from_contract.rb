class RemoveQuotaBillingDateFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :quota_expiration_day, :integer
    remove_column :contracts, :quota_billing_date, :date
    remove_column :contracts, :payday, :integer
  end
end
