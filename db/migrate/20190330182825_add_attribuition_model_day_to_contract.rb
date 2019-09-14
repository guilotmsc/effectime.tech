class AddAttribuitionModelDayToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :attribuition_model_day, :integer
  end
end
