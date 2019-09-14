class AddStartDateToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :start_moment, :datetime
    add_column :appointments, :end_moment, :datetime
  end
end
