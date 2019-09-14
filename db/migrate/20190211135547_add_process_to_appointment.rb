class AddProcessToAppointment < ActiveRecord::Migration[5.1]
  def change
    add_reference :appointments, :process_dept, foreign_key: true
  end
end
