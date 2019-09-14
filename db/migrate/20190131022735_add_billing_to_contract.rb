class AddBillingToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :billing_day, :integer
    add_column :contracts, :first_billing_date, :date
  end
end
