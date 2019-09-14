class AddAttribuitionModelWeekDayToContract < ActiveRecord::Migration[5.1]
  def change
    add_column :contracts, :attribuition_model_week_day, :string
  end
end
