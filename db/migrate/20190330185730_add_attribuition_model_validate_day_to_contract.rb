class AddAttribuitionModelValidateDayToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :attribuition_model_validate_day, :integer
  end
end
