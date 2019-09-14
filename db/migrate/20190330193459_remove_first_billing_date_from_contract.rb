class RemoveFirstBillingDateFromContract < ActiveRecord::Migration[5.1]
  def change
    remove_column :contracts, :first_billing_date, :date
  end
end
