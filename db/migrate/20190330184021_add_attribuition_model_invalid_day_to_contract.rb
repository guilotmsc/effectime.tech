class AddAttribuitionModelInvalidDayToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :attribuition_model_invalid_day, :string
  end
end
