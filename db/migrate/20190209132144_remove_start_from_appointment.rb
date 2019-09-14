class RemoveStartFromAppointment < ActiveRecord::Migration[5.1]
  def change
    remove_column :appointments, :start, :date
    remove_column :appointments, :end, :date
  end
end
