class AddTradingNameToCorporation < ActiveRecord::Migration[5.1]
  def change
    add_column :corporations, :trading_name, :string
    add_column :corporations, :document, :string
    add_column :corporations, :phone, :string
    add_column :corporations, :contact, :string
    add_column :corporations, :role, :string
    add_column :corporations, :contact_phone, :string
    add_column :corporations, :email, :string
  end
end
